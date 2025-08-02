import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'https://fakestoreapi.com', // هنستخدم بيانات وهمية
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
  }

  Future<Response> get(String endpoint) async {
    return await dio.get(endpoint);
  }
}