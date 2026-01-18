import 'package:dio/dio.dart';
import 'package:olive_app/core/dio/dio_client.dart';
import 'package:olive_app/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductApi {
  final String  _url="https://api.apidoxy.com/api/merchants/products/10";
  final String _accessToken =
      Supabase.instance.client.auth.currentSession?.accessToken ?? '';

      Future<ProductResponseModel> fetchProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await DioClient.instance.dio.get(
        "$_url?page=$page&limit=$limit",
        options: Options(headers: {'Cookie': 'access_token=$_accessToken'}),
      );
    return ProductResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}