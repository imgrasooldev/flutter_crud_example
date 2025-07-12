class Customer {
  final int id;
  final String name;
  final String type;
  final String email;
  final String address;
  final String city;
  final String state;
  final String postalCode;

  Customer({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
    );
  }
}
