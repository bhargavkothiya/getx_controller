import 'package:demo_project/app_config.dart';
import 'package:dio/dio.dart';

class DioConfig {
  static Dio getInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseURl,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("➡️ REQUEST: ${options.method} ${options.uri}");
          options.headers["Authorization"] = "Bearer your_token_here"; // ✅ NEW
          handler.next(options);
        },
        onResponse: (response, handler) {
          print("✅ RESPONSE: ${response.statusCode}");
          handler.next(response);
        },
        onError: (err, handler) {
          print("❌ ERROR: ${err.message}");
          switch (err.response?.statusCode) {
            // ✅ NEW
            case 401:
              print("🔒 Unauthorized!");
              break;
            case 404:
              print("🔍 Not Found!");
              break;
            case 500:
              print("💥 Server Error!");
              break;
          }
          handler.next(err);
        },
      ),
    );

    return dio;
  }
}
