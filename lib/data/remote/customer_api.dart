import 'package:olive_app/core/dio/dio_client.dart';
import 'package:olive_app/data/models/customer_model.dart';

class CustomerApi {
  final String _url =
      'https://api.jsonbin.io/v3/b/69661339d0ea881f4068a2b0?meta=false';

  Future<CustomerResponseModel> fetchCustomers() async {
    try {
      final response = await DioClient.instance.dio.get(_url);
      return CustomerResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
