import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._();
  static DioClient get instance => _singleton;

  late Dio dio;

  DioClient._() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
      ),
    );
  }
}
