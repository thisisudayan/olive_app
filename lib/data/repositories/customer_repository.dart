import 'package:olive_app/data/local/customer_local_datasource.dart';
import 'package:olive_app/data/models/customer_model.dart';
import 'package:olive_app/data/remote/customer_api.dart';

class CustomerRepository {
  final CustomerApi _api = CustomerApi();
  final CustomerLocalDataSource _localDataSource = CustomerLocalDataSource();

  Stream<List<CustomerModel>> watchCustomers() {
    return _localDataSource.watchCustomers();
  }

  Future<void> refreshCustomers() async {
    try {
      final response = await _api.fetchCustomers();
      await _localDataSource.saveCustomers(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CustomerModel>> getCustomers() async {
    return _localDataSource.getCustomers();
  }
}
