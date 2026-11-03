import 'package:flutter_pasteleria_26/data/models/cliente_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/cliente_repository.dart';

class CustomerService {
  final CustomerRepository _customerRepository;

  const CustomerService(this._customerRepository);

  Future<List<CustomerModel>> searchCustomers(Map<String, String>? params) async {
    return await _customerRepository.search(params);
  }
}