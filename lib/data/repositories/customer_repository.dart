import 'package:olive_app/data/local/customer_local_datasource.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/data/remote/customer_api.dart';

class CustomerRepository {
  final CustomerApi _api = CustomerApi();
  final CustomerLocalDataSource _localDataSource = CustomerLocalDataSource();

  Stream<List<CustomerModel>> watchCustomers() {
    return _localDataSource.watchCustomers();
  }

  Future<CustomerResponseModel> refreshCustomers({
    int page = 1,
    int limit = 10,
    bool clear = true,
  }) async {
    try {
      final response = await _api.fetchCustomers(page: page, limit: limit);
      await _localDataSource.saveCustomers(response.data, clear: clear);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerResponseModel> loadMoreCustomers({
    required int page,
    int limit = 10,
  }) async {
    return refreshCustomers(page: page, limit: limit, clear: false);
  }

  Future<List<CustomerModel>> getCustomers() async {
    return _localDataSource.getCustomers();
  }
}
