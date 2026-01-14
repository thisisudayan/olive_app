import 'package:dio/dio.dart';
import 'package:olive_app/core/dio/dio_client.dart';
import 'package:olive_app/data/models/customer_model.dart';

class CustomerApi {
  final String _url = 'https://api.apidoxy.com/api/merchants/customers/10';
  // ignore: non_constant_identifier_names
  final String _access_token =
      'eyJhbGciOiJIUzI1NiIsImtpZCI6Ik5UQW9jVVNxc0cxaGIrbksiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3ZyYmxwZG11dWF1amRvbnBka3V1LnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiI0OWZmYTI3ZC03ZDZiLTRlNjEtYTE0ZS0wMjdmOGQ3MDkwMGYiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzY4NDA5NzkzLCJpYXQiOjE3Njg0MDYxOTMsImVtYWlsIjoidWRheWFuLnNhbnR1QGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZ29vZ2xlIiwicHJvdmlkZXJzIjpbImdvb2dsZSJdfSwidXNlcl9tZXRhZGF0YSI6eyJhdmF0YXJfdXJsIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jTGJyLWhRcUhIN0JBdEpJQk1rdG84b3lwN3dYYmZCM1p5d2RHdW1obHJMdmhtRzlKbFdyZz1zOTYtYyIsImVtYWlsIjoidWRheWFuLnNhbnR1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmdWxsX25hbWUiOiJVZGF5YW4gQmFzYWsiLCJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYW1lIjoiVWRheWFuIEJhc2FrIiwicGhvbmVfdmVyaWZpZWQiOmZhbHNlLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jTGJyLWhRcUhIN0JBdEpJQk1rdG84b3lwN3dYYmZCM1p5d2RHdW1obHJMdmhtRzlKbFdyZz1zOTYtYyIsInByb3ZpZGVyX2lkIjoiMTAxOTk3ODc3ODY4ODUxNTY5ODIyIiwic3ViIjoiMTAxOTk3ODc3ODY4ODUxNTY5ODIyIn0sInJvbGUiOiJhdXRoZW50aWNhdGVkIiwiYWFsIjoiYWFsMSIsImFtciI6W3sibWV0aG9kIjoib2F1dGgiLCJ0aW1lc3RhbXAiOjE3NjgyOTQ1OTh9XSwic2Vzc2lvbl9pZCI6ImU0ZDliY2I4LTk4NmMtNDA4NC1hYjUyLWY1ODdkMTlmYzRmYSIsImlzX2Fub255bW91cyI6ZmFsc2V9.A68gu6hlO5lWyAo6qIZYAGeb8D0_OA11eXuDRcJeQz8';

  Future<CustomerResponseModel> fetchCustomers({
    int page = 1,
    int limit = 10,
  }) async {
    // send cookie access_token
    try {
      final response = await DioClient.instance.dio.get(
        "$_url?page=$page&limit=$limit",
        options: Options(headers: {'Cookie': 'access_token=$_access_token'}),
      );
      return CustomerResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
