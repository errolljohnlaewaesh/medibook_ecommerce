# Add these routes to your Flask application to support the mobile courier app

from flask import Blueprint, request, jsonify, session
from blueprints.get_user_info import get_personal_info, get_address_info, get_contact_info
from blueprints.courier_dashboard import get_courier_dashboard_stats, get_chart_data, get_recent_deliveries
from db_connection import get_db_connection
from datetime import datetime, timedelta
import json
import functools
import base64
import os

# Create a blueprint for mobile API endpoints
mobile_api_bp = Blueprint('courier_mobile_api', __name__)

def serialize_datetime(obj):
    """Convert datetime objects to ISO format strings"""
    if isinstance(obj, datetime):
        return obj.isoformat()
    return obj

def serialize_data(data):
    """Recursively serialize datetime objects in data structures"""
    if isinstance(data, dict):
        return {key: serialize_data(value) for key, value in data.items()}
    elif isinstance(data, list):
        return [serialize_data(item) for item in data]
    elif isinstance(data, datetime):
        return data.isoformat()
    else:
        return data

# Authentication decorator for mobile API
def mobile_auth_required(f):
    @functools.wraps(f)
    def decorated_function(*args, **kwargs):
        # Check if courier is authenticated through mobile login
        auth_header = request.headers.get('Authorization')
        courier_id = request.headers.get('X-Courier-ID')
        
        if courier_id:
            # Use courier ID from mobile app headers
            try:
                session['courier'] = int(courier_id)
            except (ValueError, TypeError):
                return jsonify({'success': False, 'message': 'Invalid courier ID format'}), 401
        elif 'courier' not in session:
            # No authentication found
            return jsonify({'success': False, 'message': 'Authentication required'}), 401
            
        return f(*args, **kwargs)
    return decorated_function

@mobile_api_bp.route('/api/test', methods=['GET'])
def mobile_test():
    """Test endpoint to verify API is working"""
    return jsonify({
        'success': True,
        'message': 'Mobile API is working!',
        'timestamp': datetime.now().isoformat()
    })

@mobile_api_bp.route('/api/courier/dashboard', methods=['GET'])
@mobile_auth_required
def mobile_dashboard():
    """Mobile API endpoint for courier dashboard data"""
    try:
        courier_id = session.get('courier')
        print(f"Loading dashboard for courier ID: {courier_id}")
        
        # Get query parameters
        date_filter = request.args.get('date_filter', 'today')
        sort_by = request.args.get('sort_by', 'date_delivered')
        order = request.args.get('order', 'desc')
        custom_date = request.args.get('custom_date', '')
        chart_period = request.args.get('chart_period', 'last_7_days')
        chart_custom_date = request.args.get('chart_custom_date', '')
        
        print(f"Dashboard params: date_filter={date_filter}, chart_period={chart_period}")
        
        # Convert custom date
        custom_date_formatted = None
        if custom_date:
            try:
                custom_date_formatted = datetime.strptime(custom_date, '%Y-%m-%d').date()
            except ValueError:
                pass
        
        chart_custom_date_formatted = None
        if chart_custom_date:
            try:
                chart_custom_date_formatted = datetime.strptime(chart_custom_date, '%Y-%m-%d').date()
            except ValueError:
                pass
        
        # Get dashboard data
        stats = get_courier_dashboard_stats(courier_id, date_filter, custom_date_formatted)
        recent_deliveries = get_recent_deliveries(courier_id, 10, sort_by, order)
        chart_data_raw = get_chart_data(courier_id, chart_period, chart_custom_date_formatted)
        
        print(f"Stats: {stats}")
        print(f"Recent deliveries count: {len(recent_deliveries)}")
        print(f"Chart data count: {len(chart_data_raw)}")
        
        # Format chart data for mobile with proper labels
        chart_data = _format_chart_data(chart_data_raw, chart_period)
        
        return jsonify({
            'success': True,
            'earnings_stats': {
                'total_deliveries': int(stats['earnings_stats']['total_deliveries'] or 0),
                'total_earnings': float(stats['earnings_stats']['total_earnings'] or 0),
                'average_earning': float(stats['earnings_stats']['average_earning'] or 0),
                'highest_earning': float(stats['earnings_stats']['highest_earning'] or 0)
            },
            'delivery_stats': {
                'pending_deliveries': int(stats['delivery_stats']['pending_deliveries'] or 0),
                'active_deliveries': int(stats['delivery_stats']['active_deliveries'] or 0),
                'completed_deliveries': int(stats['delivery_stats']['completed_deliveries'] or 0),
                'total_assigned_deliveries': int(stats['delivery_stats']['total_assigned_deliveries'] or 0)
            },
            'chart_data': chart_data,
            'recent_deliveries': serialize_data(recent_deliveries)
        })
    
    except Exception as e:
        print(f"Dashboard error: {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'message': str(e)}), 500

@mobile_api_bp.route('/api/courier/finance', methods=['GET'])
@mobile_auth_required
def mobile_finance():
    """Mobile API endpoint for courier financial data"""
    try:
        courier_id = session.get('courier')
        
        # Get query parameters
        date_filter = request.args.get('date_filter', 'this_month')
        sort_by = request.args.get('sort_by', 'date_created')
        order = request.args.get('order', 'desc')
        search_query = request.args.get('search', '')
        custom_date = request.args.get('custom_date', '')
        
        # Convert custom date
        custom_date_formatted = None
        if custom_date:
            try:
                custom_date_formatted = datetime.strptime(custom_date, '%Y-%m-%d').date()
            except ValueError:
                pass
        
        # Get detailed financial breakdown with full sales data
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        
        # Base date filter condition
        date_condition = ""
        params = [courier_id]
        
        if custom_date_formatted:
            date_condition = " AND DATE(cs.date_created) = %s"
            params.append(custom_date_formatted)
        elif date_filter == 'today':
            date_condition = " AND DATE(cs.date_created) = CURDATE()"
        elif date_filter == 'this_week':
            date_condition = " AND cs.date_created >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)"
        elif date_filter == 'this_month':
            date_condition = " AND cs.date_created >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)"
        elif date_filter == 'this_year':
            date_condition = " AND cs.date_created >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)"
        
        # Add search filter
        search_condition = ""
        if search_query:
            search_condition = """ AND (
                pi.product_name LIKE %s OR
                pi.product_category LIKE %s OR
                buyer_pi.firstname LIKE %s OR
                buyer_pi.lastname LIKE %s OR
                seller_pi.firstname LIKE %s OR
                seller_pi.lastname LIKE %s OR
                bo.order_id LIKE %s
            )"""
            search_term = f"%{search_query}%"
            params.extend([search_term] * 7)
        
        # Add sorting
        allowed_sort_columns = {
            'date_created': 'cs.date_created',
            'product_name': 'pi.product_name',
            'order_id': 'bo.order_id',
            'delivery_fee': 'cs.sale',
            'total_amount': 'bo.total_amount',
            'buyer_name': 'buyer_pi.firstname',
            'seller_name': 'seller_pi.firstname'
        }
        
        sort_column = allowed_sort_columns.get(sort_by, 'cs.date_created')
        order_direction = 'DESC' if order.lower() == 'desc' else 'ASC'
        order_clause = f" ORDER BY {sort_column} {order_direction}"
        
        # Get detailed sales data with all required fields
        cursor.execute(f"""
            SELECT 
                cs.sales_id,
                cs.order_id,
                cs.sale as delivery_fee,
                cs.date_created,
                bo.quantity,
                bo.total_amount,
                bo.payment_method,
                bo.payment_status,
                bo.status as order_status,
                bo.date_ordered,
                p.price,
                p.shipping_fee,
                pi.product_name,
                pi.product_main_pic,
                pi.product_category,
                buyer_pi.firstname as buyer_firstname,
                buyer_pi.lastname as buyer_lastname,
                buyer_ci.email as buyer_email,
                buyer_ci.phone as buyer_phone,
                seller_pi.firstname as seller_firstname,
                seller_pi.lastname as seller_lastname,
                CONCAT(buyer_ai.house_no, ' ', buyer_ai.street, ', ', buyer_ai.barangay, ', ', buyer_ai.city, ', ', buyer_ai.province, ', ', buyer_ai.region) as delivery_address,
                od.status as delivery_status,
                od.date_delivered as delivery_date
            FROM courier_sales cs
            JOIN buyer_order bo ON cs.order_id = bo.order_id
            JOIN product p ON bo.product_id = p.product_id
            JOIN product_info pi ON p.product_info_id = pi.product_info_id
            JOIN user_account buyer_ua ON bo.buyer_id = buyer_ua.user_id
            JOIN account_personal_info buyer_pi ON buyer_ua.personal_id = buyer_pi.personal_id
            JOIN account_contact_info buyer_ci ON buyer_ua.contact_id = buyer_ci.contact_id
            JOIN account_address_info buyer_ai ON buyer_ua.address_id = buyer_ai.address_id
            JOIN user_account seller_ua ON bo.seller_id = seller_ua.user_id
            JOIN account_personal_info seller_pi ON seller_ua.personal_id = seller_pi.personal_id
            LEFT JOIN order_delivery od ON bo.order_id = od.order_id
            WHERE cs.courier_id = %s {date_condition} {search_condition}
            {order_clause}
            LIMIT 100
        """, params)
        
        sales = cursor.fetchall()
        
        # Calculate statistics
        stats_query = f"""
            SELECT 
                COUNT(*) as total_deliveries,
                COALESCE(SUM(cs.sale), 0) as total_earnings,
                COALESCE(AVG(cs.sale), 0) as average_delivery_fee,
                COALESCE(MIN(cs.sale), 0) as min_delivery_fee,
                COALESCE(MAX(cs.sale), 0) as max_delivery_fee
            FROM courier_sales cs
            WHERE cs.courier_id = %s {date_condition}
        """
        
        stats_params = [courier_id]
        if custom_date_formatted:
            stats_params.append(custom_date_formatted)
        
        cursor.execute(stats_query, stats_params)
        statistics = cursor.fetchone()
        
        # Convert Decimal to float for JSON serialization
        if statistics:
            for key in ['total_earnings', 'average_delivery_fee', 'min_delivery_fee', 'max_delivery_fee']:
                if statistics[key] is not None:
                    statistics[key] = float(statistics[key])
        
        # Convert datetime objects to strings for JSON serialization
        for sale in sales:
            if sale['date_created']:
                sale['date_created'] = sale['date_created'].strftime('%Y-%m-%d %H:%M:%S')
            if sale['date_ordered']:
                sale['date_ordered'] = sale['date_ordered'].strftime('%Y-%m-%d %H:%M:%S')
            if sale['delivery_date']:
                sale['delivery_date'] = sale['delivery_date'].strftime('%Y-%m-%d %H:%M:%S')
            # Convert decimal to float
            if sale['delivery_fee']:
                sale['delivery_fee'] = float(sale['delivery_fee'])
            if sale['total_amount']:
                sale['total_amount'] = float(sale['total_amount'])
            if sale['price']:
                sale['price'] = float(sale['price'])
            if sale['shipping_fee']:
                sale['shipping_fee'] = float(sale['shipping_fee'])
        
        cursor.close()
        connection.close()
        
        return jsonify({
            'sales': sales,
            'statistics': statistics,
            'filters': {
                'date_filter': date_filter,
                'sort_by': sort_by,
                'order': order,
                'search_query': search_query,
                'custom_date': custom_date
            }
        })
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@mobile_api_bp.route('/api/courier/notifications', methods=['GET'])
@mobile_auth_required
def mobile_notifications():
    """Mobile API endpoint for courier notifications"""
    try:
        courier_id = session.get('courier')
        
        # Get query parameters
        page = int(request.args.get('page', 1))
        limit = int(request.args.get('limit', 20))
        
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        
        # Get notifications with pagination
        offset = (page - 1) * limit
        
        cursor.execute("""
            SELECT 
                notification_id,
                notification_type,
                notification_title,
                content,
                status,
                created_at
            FROM notifications
            WHERE recipient_id = %s
            ORDER BY created_at DESC
            LIMIT %s OFFSET %s
        """, [courier_id, limit, offset])
        
        notifications = cursor.fetchall()
        
        # Get unread count
        cursor.execute("""
            SELECT COUNT(*) as unread_count
            FROM notifications
            WHERE recipient_id = %s AND status = 'Unread'
        """, [courier_id])
        
        unread_count = cursor.fetchone()['unread_count']
        
        cursor.close()
        connection.close()
        
        return jsonify({
            'success': True,
            'notifications': notifications,
            'unread_count': unread_count,
            'pagination': {
                'page': page,
                'limit': limit,
                'total': len(notifications)
            }
        })
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

@mobile_api_bp.route('/api/courier/notifications/read', methods=['POST'])
@mobile_auth_required
def mobile_mark_notifications_read():
    """Mobile API endpoint to mark notifications as read"""
    try:
        courier_id = session.get('courier')
        
        connection = get_db_connection()
        cursor = connection.cursor()
        
        cursor.execute("""
            UPDATE notifications 
            SET status = 'Read' 
            WHERE recipient_id = %s AND status = 'Unread'
        """, [courier_id])
        
        connection.commit()
        cursor.close()
        connection.close()
        
        return jsonify({'success': True, 'message': 'Notifications marked as read'})
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

@mobile_api_bp.route('/api/courier/notifications/count', methods=['GET'])
@mobile_auth_required
def mobile_notifications_count():
    """Mobile API endpoint to get unread notifications count"""
    try:
        courier_id = session.get('courier')
        
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        
        cursor.execute("""
            SELECT COUNT(*) as unread_count
            FROM notifications
            WHERE recipient_id = %s AND status = 'Unread'
        """, [courier_id])
        
        result = cursor.fetchone()
        unread_count = result['unread_count'] if result else 0
        
        cursor.close()
        connection.close()
        
        return jsonify({
            'success': True,
            'count': unread_count
        })
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

@mobile_api_bp.route('/api/courier/debug', methods=['GET'])
@mobile_auth_required
def mobile_debug():
    """Debug endpoint to test authentication and courier data"""
    try:
        courier_id = session.get('courier')
        
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        
        # Get courier info
        cursor.execute("""
            SELECT ua.user_id, ua.status, 
                   pi.firstname, pi.lastname,
                   ci.email, ci.phone
            FROM user_account ua
            JOIN account_personal_info pi ON ua.personal_id = pi.personal_id
            JOIN account_contact_info ci ON ua.contact_id = ci.contact_id
            WHERE ua.user_id = %s AND ua.user_role = 'Courier'
        """, [courier_id])
        
        courier_info = cursor.fetchone()
        
        # Get delivery count
        cursor.execute("""
            SELECT COUNT(*) as delivery_count
            FROM order_delivery
            WHERE courier_id = %s
        """, [courier_id])
        
        delivery_count = cursor.fetchone()['delivery_count']
        
        cursor.close()
        connection.close()
        
        return jsonify({
            'success': True,
            'debug_info': {
                'courier_id': courier_id,
                'courier_info': courier_info,
                'delivery_count': delivery_count,
                'session_data': dict(session),
                'headers': dict(request.headers)
            }
        })
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e), 'error_details': str(e)}), 500

def _format_chart_data(chart_data_raw, chart_period):
    """Format chart data with proper labels based on time period"""
    from datetime import datetime, timedelta
    
    # For Last 7 Days, always generate proper day sequence regardless of real data
    if chart_period == 'last_7_days':
        today = datetime.now()
        labels = []
        earnings = []
        deliveries = []
        
        # Generate last 7 days with proper day names
        for i in range(7):
            date = today - timedelta(days=6-i)
            labels.append(date.strftime('%A'))  # Monday, Tuesday, etc.
            
            # Try to find real data for this date if available
            daily_earning = 0
            daily_delivery = 0
            if chart_data_raw:
                for item in chart_data_raw:
                    try:
                        if isinstance(item['date'], datetime):
                            item_date = item['date']
                        else:
                            # Try different date format parsing
                            date_str = str(item['date'])
                            if 'T' in date_str:
                                item_date = datetime.fromisoformat(date_str.replace('Z', '+00:00'))
                            else:
                                item_date = datetime.strptime(date_str, '%Y-%m-%d')
                        
                        if item_date.date() == date.date():
                            daily_earning = float(item['daily_earnings'])
                            daily_delivery = item['daily_deliveries']
                            break
                    except (ValueError, KeyError) as e:
                        print(f"Error parsing date: {e}, item: {item}")
                        continue
            
            # Use real data if found, otherwise use 0
            earnings.append(daily_earning)
            deliveries.append(daily_delivery)
        
        return {
            'daily_labels': labels,
            'daily_earnings': earnings,
            'daily_deliveries': deliveries
        }
    
    # For other periods, use the existing logic but with proper handling
    if chart_data_raw and len(chart_data_raw) > 0:
        earnings = [float(item['daily_earnings']) for item in chart_data_raw]
        deliveries = [item['daily_deliveries'] for item in chart_data_raw]
        dates = [item['date'] if isinstance(item['date'], datetime) else datetime.strptime(str(item['date']), '%Y-%m-%d') for item in chart_data_raw]
        
        # Generate labels based on period
        if chart_period == 'last_14_days':
            # Show only 7 evenly spaced dates from the 14 days
            if len(dates) > 7:
                indices = [i * (len(dates) - 1) // 6 for i in range(7)]
                dates = [dates[i] for i in indices]
                earnings = [earnings[i] for i in indices]
                deliveries = [deliveries[i] for i in indices]
            labels = [date.strftime('%m/%d') for date in dates]
        elif chart_period == 'last_30_days':
            # Show only 7 evenly spaced dates from the 30 days
            if len(dates) > 7:
                indices = [i * (len(dates) - 1) // 6 for i in range(7)]
                dates = [dates[i] for i in indices]
                earnings = [earnings[i] for i in indices]
                deliveries = [deliveries[i] for i in indices]
            labels = [date.strftime('%m/%d') for date in dates]
        elif chart_period == 'this_month':
            # Show only 7 evenly spaced dates from this month
            if len(dates) > 7:
                indices = [i * (len(dates) - 1) // 6 for i in range(7)]
                dates = [dates[i] for i in indices]
                earnings = [earnings[i] for i in indices]
                deliveries = [deliveries[i] for i in indices]
            labels = [date.strftime('%m/%d') for date in dates]
        else:
            labels = [date.strftime('%m/%d') for date in dates]
        
        return {
            'daily_labels': labels,
            'daily_earnings': earnings,
            'daily_deliveries': deliveries
        }
    
    # Generate mock data with proper labels for demonstration when no real data
    today = datetime.now()
    
    if chart_period == 'last_14_days':
        # Generate 7 representative days from last 14 days with 0 data
        labels = []
        earnings = []
        deliveries = []
        for i in range(7):
            days_back = 13 - (i * 2)  # Every 2 days
            date = today - timedelta(days=days_back)
            labels.append(date.strftime('%m/%d'))
            earnings.append(0)  # No fake data, just 0
            deliveries.append(0)
    
    elif chart_period == 'last_30_days':
        # Generate 7 representative days from last 30 days with 0 data
        labels = []
        earnings = []
        deliveries = []
        for i in range(7):
            days_back = 29 - (i * 4)  # Every ~4 days
            date = today - timedelta(days=days_back)
            labels.append(date.strftime('%m/%d'))
            earnings.append(0)  # No fake data, just 0
            deliveries.append(0)
    
    elif chart_period == 'this_month':
        # Generate 7 representative days from this month with 0 data
        labels = []
        earnings = []
        deliveries = []
        start_of_month = today.replace(day=1)
        days_in_period = (today - start_of_month).days + 1
        
        for i in range(min(7, days_in_period)):
            if days_in_period > 7:
                day_offset = i * (days_in_period - 1) // 6
            else:
                day_offset = i
            date = start_of_month + timedelta(days=day_offset)
            if date <= today:
                labels.append(date.strftime('%m/%d'))
                earnings.append(0)  # No fake data, just 0
                deliveries.append(0)
    
    else:
        # Default fallback - show empty data instead of fake data
        labels = ['No Data'] * 7
        earnings = [0] * 7
        deliveries = [0] * 7
    
    return {
        'daily_labels': labels,
        'daily_earnings': earnings,
        'daily_deliveries': deliveries
    }

# Don't forget to register this blueprint in your main Flask app:
# app.register_blueprint(mobile_api_bp)

# BUYER SHOP API ROUTES
@mobile_api_bp.route('/api/buyer/shop/<int:shop_id>', methods=['GET'])
def get_shop_details_mobile(shop_id):
    """Mobile endpoint for shop details"""
    try:
        user_id = request.args.get('user_id', type=int)
        limit = request.args.get('limit', default=20, type=int)
        offset = request.args.get('offset', default=0, type=int)
        sort = request.args.get('sort', default='recent')

        def get_shop_image_base64(image_filename):
            if not image_filename:
                return None
            try:
                image_path = os.path.join("static", "uploads", "seller", "shop_profile", image_filename)
                if os.path.exists(image_path):
                    with open(image_path, 'rb') as image_file:
                        encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
                        return f"data:image/jpeg;base64,{encoded_string}"
            except Exception as e:
                print(f"Error loading shop image {image_filename}: {e}")
            return None

        def get_product_image_base64(image_filename):
            if not image_filename:
                return None
            try:
                image_path = os.path.join("static", "uploads", "seller", "product_main_pics", image_filename)
                if os.path.exists(image_path):
                    with open(image_path, 'rb') as image_file:
                        encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
                        return f"data:image/jpeg;base64,{encoded_string}"
            except Exception as e:
                print(f"Error loading product image {image_filename}: {e}")
            return None

        def is_product_liked_by_user(product_info_id, user_id):
            if not user_id:
                return False
            try:
                connection = get_db_connection()
                if not connection:
                    return False
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT 1 FROM buyer_like
                    WHERE product_info_id = %s AND buyer_id = %s
                """, (product_info_id, user_id))
                result = cursor.fetchone()
                cursor.close()
                connection.close()
                return bool(result)
            except Exception as e:
                print(f"Error checking like status: {e}")
                return False

        connection = get_db_connection()
        if not connection:
            return jsonify({
                'status': 'error',
                'message': 'Database connection error'
            }), 500

        cursor = connection.cursor(dictionary=True)

        # Get shop information
        cursor.execute("""
            SELECT si.shop_info_id as shop_id, si.shop_name, si.shop_description, si.shop_pic,
                   pi.firstname as first_name, pi.lastname as last_name, ua.user_id as seller_id
            FROM shop_info si
            JOIN user_account ua ON si.shop_info_id = ua.business_id
            JOIN account_personal_info pi ON ua.personal_id = pi.personal_id
            WHERE si.shop_info_id = %s AND ua.status = 'Approved'
        """, (shop_id,))
        
        shop_info = cursor.fetchone()
        
        if not shop_info:
            cursor.close()
            connection.close()
            return jsonify({
                'status': 'error',
                'message': 'Shop not found'
            }), 404

        # Get shop statistics - simplified without ratings
        cursor.execute("""
            SELECT 
                COUNT(DISTINCT p.product_id) as total_products,
                COUNT(DISTINCT bo.order_id) as total_orders
            FROM shop_listing sl
            LEFT JOIN product p ON sl.product_id = p.product_id
            LEFT JOIN buyer_order bo ON p.product_id = bo.product_id
            WHERE sl.shop_id = %s AND p.status = 'Active'
        """, (shop_id,))
        
        shop_stats = cursor.fetchone()

        # Build sort clause - simplified
        sort_clause = "ORDER BY p.date_added DESC"  # default
        if sort == 'price_low':
            sort_clause = "ORDER BY p.price ASC"
        elif sort == 'price_high':
            sort_clause = "ORDER BY p.price DESC"
        elif sort == 'popular':
            sort_clause = "ORDER BY order_count DESC, p.date_added DESC"

        # Get shop products with pagination - simplified
        products_query = f"""
            SELECT 
                pi.product_info_id,
                pi.product_name,
                pi.product_description,
                pi.product_category,
                pi.product_main_pic,
                p.date_added,
                p.product_id,
                p.price,
                p.shipping_fee,
                p.stock,
                CASE 
                    WHEN p.stock > 0 THEN 'In Stock'
                    ELSE 'Out of Stock'
                END as stock_status,
                COALESCE(order_count, 0) as order_count
            FROM shop_listing sl
            JOIN product p ON sl.product_id = p.product_id
            JOIN product_info pi ON p.product_info_id = pi.product_info_id
            LEFT JOIN (
                SELECT p.product_id, 
                       COUNT(bo.order_id) as order_count
                FROM product p
                LEFT JOIN buyer_order bo ON p.product_id = bo.product_id
                GROUP BY p.product_id
            ) stats ON p.product_id = stats.product_id
            WHERE sl.shop_id = %s 
            AND p.status = 'Active'
            {sort_clause}
            LIMIT %s OFFSET %s
        """
        
        cursor.execute(products_query, (shop_id, limit, offset))
        products_raw = cursor.fetchall()

        # Get total product count
        cursor.execute("""
            SELECT COUNT(DISTINCT p.product_id) as total_count
            FROM shop_listing sl
            JOIN product p ON sl.product_id = p.product_id
            WHERE sl.shop_id = %s 
            AND p.status = 'Active'
        """, (shop_id,))
        
        total_count_result = cursor.fetchone()
        total_count = total_count_result['total_count'] if total_count_result else 0

        cursor.close()
        connection.close()

        # Process shop info
        shop_data = {
            'shop_id': shop_info['shop_id'],
            'shop_name': shop_info['shop_name'],
            'shop_description': shop_info['shop_description'],
            'shop_pic': shop_info['shop_pic'],
            'shop_image_base64': get_shop_image_base64(shop_info['shop_pic']),
            'seller_id': shop_info['seller_id'],
            'seller_name': f"{shop_info['first_name']} {shop_info['last_name']}".strip(),
            'statistics': {
                'total_products': shop_stats['total_products'] or 0,
                'total_orders': shop_stats['total_orders'] or 0,
                'average_rating': 0,
                'total_reviews': 0
            }
        }

        # Process products
        products = []
        for product in products_raw:
            is_liked = is_product_liked_by_user(product['product_info_id'], user_id)
            
            products.append({
                'product_info_id': product['product_info_id'],
                'product_id': product['product_id'],
                'product_name': product['product_name'],
                'product_description': product['product_description'],
                'product_category': product['product_category'],
                'product_main_pic': product['product_main_pic'],
                'product_image_base64': get_product_image_base64(product['product_main_pic']),
                'price': float(product['price']),
                'shipping_fee': float(product['shipping_fee']),
                'stock': product['stock'],
                'stock_status': product['stock_status'],
                'date_added': product['date_added'].isoformat() if product['date_added'] else None,
                'order_count': product['order_count'],
                'average_rating': 0,
                'review_count': 0,
                'is_liked': is_liked
            })

        return jsonify({
            'status': 'success',
            'data': {
                'shop': shop_data,
                'products': products,
                'pagination': {
                    'total_count': total_count,
                    'limit': limit,
                    'offset': offset,
                    'has_more': offset + limit < total_count
                }
            }
        })

    except Exception as e:
        print(f"Error in get_shop_details: {e}")
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 500

@mobile_api_bp.route('/api/buyer/shops', methods=['GET'])
def get_shops_mobile():
    """Mobile endpoint for shops list"""
    try:
        limit = request.args.get('limit', default=20, type=int)
        offset = request.args.get('offset', default=0, type=int)
        search = request.args.get('search', default='')

        def get_shop_image_base64(image_filename):
            if not image_filename:
                return None
            try:
                image_path = os.path.join("static", "uploads", "seller", "shop_profile", image_filename)
                if os.path.exists(image_path):
                    with open(image_path, 'rb') as image_file:
                        encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
                        return f"data:image/jpeg;base64,{encoded_string}"
            except Exception as e:
                print(f"Error loading shop image {image_filename}: {e}")
            return None

        connection = get_db_connection()
        if not connection:
            return jsonify({
                'status': 'error',
                'message': 'Database connection error'
            }), 500

        cursor = connection.cursor(dictionary=True)

        # Build search condition
        search_condition = ""
        search_params = []
        if search:
            search_condition = "AND (si.shop_name LIKE %s OR si.shop_description LIKE %s)"
            search_params = [f"%{search}%", f"%{search}%"]

        # Get shops with statistics - simplified
        shops_query = f"""
            SELECT 
                si.shop_info_id as shop_id,
                si.shop_name,
                si.shop_description,
                si.shop_pic,
                pi.firstname as first_name,
                pi.lastname as last_name,
                ua.user_id as seller_id,
                COUNT(DISTINCT p.product_id) as total_products
            FROM shop_info si
            JOIN user_account ua ON si.shop_info_id = ua.business_id
            JOIN account_personal_info pi ON ua.personal_id = pi.personal_id
            LEFT JOIN shop_listing sl ON si.shop_info_id = sl.shop_id
            LEFT JOIN product p ON sl.product_id = p.product_id
            WHERE ua.status = 'Approved' {search_condition}
            GROUP BY si.shop_info_id, si.shop_name, si.shop_description, si.shop_pic, 
                     pi.firstname, pi.lastname, ua.user_id
            ORDER BY total_products DESC, si.shop_name ASC
            LIMIT %s OFFSET %s
        """
        
        params = search_params + [limit, offset]
        cursor.execute(shops_query, params)
        shops_raw = cursor.fetchall()

        # Get total shop count
        count_query = f"""
            SELECT COUNT(DISTINCT si.shop_info_id) as total_count
            FROM shop_info si
            JOIN user_account ua ON si.shop_info_id = ua.business_id
            WHERE ua.status = 'Approved' {search_condition}
        """
        
        cursor.execute(count_query, search_params)
        total_count_result = cursor.fetchone()
        total_count = total_count_result['total_count'] if total_count_result else 0

        cursor.close()
        connection.close()

        # Process shops
        shops = []
        for shop in shops_raw:
            shops.append({
                'shop_id': shop['shop_id'],
                'shop_name': shop['shop_name'],
                'shop_description': shop['shop_description'],
                'shop_pic': shop['shop_pic'],
                'shop_image_base64': get_shop_image_base64(shop['shop_pic']),
                'seller_id': shop['seller_id'],
                'seller_name': f"{shop['first_name']} {shop['last_name']}".strip(),
                'total_products': shop['total_products'] or 0,
                'average_rating': 0,
                'total_reviews': 0
            })

        return jsonify({
            'status': 'success',
            'data': {
                'shops': shops,
                'pagination': {
                    'total_count': total_count,
                    'limit': limit,
                    'offset': offset,
                    'has_more': offset + limit < total_count
                },
                'search': search
            }
        })

    except Exception as e:
        print(f"Error in get_shops: {e}")
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 500 