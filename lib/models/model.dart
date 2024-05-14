class User {
  final int id;
  final String name;
  final String userName;
  User({
    required this.id,
    required this.name,
    required this.userName,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], userName: json['username']);
  }
}
