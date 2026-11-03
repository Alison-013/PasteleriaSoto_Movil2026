class CustomerModel {
  final int customerId;
  final String cedula;
  final String customerName;
  final String customerAddress;
  final String city;
  final String phone;
  final bool isActive;

  final int pedidos;

  CustomerModel({
    required this.customerId,
    required this.cedula,
    required this.customerName,
    required this.customerAddress,
    required this.city,
    required this.phone,
    required this.isActive,
    this.pedidos = 0,
  });

  static CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customerId'] as int,
      cedula: (json['cedula'] ?? '') as String,
      customerName: json['customerName'] as String,
      customerAddress: (json['customerAddress'] ?? '') as String,
      city: (json['city'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      isActive: json['isActive'] as bool,
    );
  }

  CustomerModel conPedidos(int pedidos) {
    return CustomerModel(
      customerId: customerId,
      cedula: cedula,
      customerName: customerName,
      customerAddress: customerAddress,
      city: city,
      phone: phone,
      isActive: isActive,
      pedidos: pedidos,
    );
  }
}