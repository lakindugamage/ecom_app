class User {
  final String name;
  final String address;
  final String contactNumber;

  User({
    required this.name,
    required this.address,
    required this.contactNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      address: json['address'],
      contactNumber: json['contactNumber'],
    );
  }
}
