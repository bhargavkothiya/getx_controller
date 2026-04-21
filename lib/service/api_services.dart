// lib/services/api_service.dart

import 'package:demo_project/config/dio_config.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = DioConfig.getInstance();

  // GET
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // POST
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // PUT
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // DELETE
  Future<void> delete(String endpoint) async {
    try {
      await _dio.delete(endpoint);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
