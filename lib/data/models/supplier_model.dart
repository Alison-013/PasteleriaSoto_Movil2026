class SupplierModel {
  final int supplierId;
  final String supplierName;
  final String location;
  final String phone;
  final bool isActive;

  final String detalle;

  SupplierModel({
    required this.supplierId,
    required this.supplierName,
    required this.location,
    required this.phone,
    required this.isActive,
    this.detalle = 'Sin productos',
  });

  static SupplierModel fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      supplierId: json['supplierId'] as int,
      supplierName: json['name'] as String,
      location: (json['location'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      isActive: json['isActive'] as bool,
    );
  }

  SupplierModel conDetalle(String detalle) {
    return SupplierModel(
      supplierId: supplierId,
      supplierName: supplierName,
      location: location,
      phone: phone,
      isActive: isActive,
      detalle: detalle,
    );
  }

  String get codigo => 'Cód: PRV-${supplierId.toString().padLeft(4, '0')}';
}