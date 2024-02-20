
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
