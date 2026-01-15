import 'package:dio/dio.dart';
import 'package:olive_app/core/dio/dio_client.dart';
import 'package:olive_app/data/models/store_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoresApi {
  final String _url = 'https://api.apidoxy.com/api/merchants/stores';

  String get _accessToken =>
      Supabase.instance.client.auth.currentSession?.accessToken ?? '';

  Future<List<StoreModel>> fetchStores() async {
    try {
      final response = await DioClient.instance.dio.get(
        _url,
        options: Options(headers: {'Cookie': 'access_token=$_accessToken'}),
      );
      print(response.data);

      final List<dynamic> stores = response.data['stores'] ?? [];
      return stores.map((json) => StoreModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
