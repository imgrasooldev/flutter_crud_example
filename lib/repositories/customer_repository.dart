import 'package:laravel_rest_blog/models/customer_model.dart';
import 'package:laravel_rest_blog/services/api_service.dart';

class CustomerRepository {
  final ApiService api = ApiService();

  Future<List<Customer>> fetchCustomers({int page = 1}) async {
  final response = await api.get('customers?page=$page', auth: true);
  final List items = response.data['data']['items'];
  return items.map((json) => Customer.fromJson(json)).toList();
  }
}
