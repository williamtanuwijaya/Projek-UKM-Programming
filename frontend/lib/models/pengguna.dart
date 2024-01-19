class Pengguna {
  int id;
  String email;
  String username;
  String password;
  String phone;
  String name;
  String reset_token;

  Pengguna({
    this.id = 0,
    this.email = '',
    required this.username,
    required this.password,
    this.phone = '',
    this.name = '',
    this.reset_token = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'name': name,
      'reset_token': reset_token,
    };
  }
}
