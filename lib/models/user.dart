class User {
  final String id;
  final String name;
  final String address;
  final String contactNumber;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contactNumber: json['contactNumber'],
    );
  }
}
