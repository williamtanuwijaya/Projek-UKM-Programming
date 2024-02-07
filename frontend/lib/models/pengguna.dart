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
    required this.email,
    required this.username,
    required this.password,
    this.phone = '',
    this.name = '',
    this.reset_token = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'name': name,
    };
  }

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: "",
      phone: json['phone'],
      name: json['name'],
      reset_token: json['reset_token'] ?? '',
    );
  }
}
