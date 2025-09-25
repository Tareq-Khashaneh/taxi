class User {
  final String id;       // UID
  final String phone;    // Phone number
  final String? name;    // Optional profile data

  const User({
    required this.id,
    required this.phone,
    this.name,
  });
}
