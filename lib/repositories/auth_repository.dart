import 'package:laravel_rest_blog/models/user_model.dart';
import 'package:laravel_rest_blog/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final _api = ApiService();

  Future<UserModel> login(String email, String password) async {
    final res = await _api.post('login', {
      'email': email,
      'password': password,
    });
    if (res.data['success'] != true) throw Exception(res.data['message']);
    final data = res.data['data'];
    final user = UserModel.fromJson(data);
    (await SharedPreferences.getInstance()).setString('token', user.token);
    return user;
  }

  Future<void> logout() async {
    (await SharedPreferences.getInstance()).remove('token');
  }
}
