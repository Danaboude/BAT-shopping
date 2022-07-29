
class User {
  String name;
  String email;
  String address;
  String phone;
  int? id;

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.id,
  });
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        address = json['address'] ?? '',
        phone = json['phone'] ?? '',
        id = json['id'];
}
class UserWithtoken {
  User user;
  String token;
  UserWithtoken({
    required this.user,
    required this.token,
  });
    UserWithtoken.fromJson(Map<String, dynamic> json)
      : user =User.fromJson(json['user']),
        token = json['token'];

 
}
