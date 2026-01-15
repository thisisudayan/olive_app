import 'package:dio/dio.dart';
import 'package:olive_app/core/dio/dio_client.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerApi {
  final String _url = 'https://api.apidoxy.com/api/merchants/customers/10';
  final String _accessToken =
      Supabase.instance.client.auth.currentSession?.accessToken ?? '';
  Future<CustomerResponseModel> fetchCustomers({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await DioClient.instance.dio.get(
        "$_url?page=$page&limit=$limit",
        options: Options(headers: {'Cookie': 'access_token=$_accessToken'}),
      );
      return CustomerResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
