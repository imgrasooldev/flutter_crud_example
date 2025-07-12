import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const _base = 'https://yolger.com/apis/public/api/v1';
  final Dio _dio = Dio();

  Future<String?> _token() async =>
      (await SharedPreferences.getInstance()).getString('token');

  Future<Response> post(String path, data, {bool auth = false}) async {
    return _dio.post(
      '$_base/$path',
      data: data,
      options: Options(
        headers: auth ? {'Authorization': 'Bearer ${await _token()}'} : null,
      ),
    );
  }

  Future<Response> get(String path, {bool auth = false}) async {
    return _dio.get(
      '$_base/$path',
      options: Options(
        headers: auth ? {'Authorization': 'Bearer ${await _token()}'} : null,
      ),
    );
  }
}
