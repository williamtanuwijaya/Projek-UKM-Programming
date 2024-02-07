import 'package:flutter/material.dart';
import 'package:ukm_project/api/api_service.dart';
import 'package:ukm_project/models/pengguna.dart';
import 'package:ukm_project/screen/sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaPenggunaController = TextEditingController();
  final TextEditingController _kataSandiController = TextEditingController();
  final TextEditingController _konfirmasiSandiController =
      TextEditingController();

  final ApiService apiService = ApiService();

  bool isAgreed = false;

  void _signUp() async {
    if (_namaLengkapController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _namaPenggunaController.text.isNotEmpty &&
        _kataSandiController.text.isNotEmpty &&
        _konfirmasiSandiController.text.isNotEmpty) {
      if (_kataSandiController.text == _konfirmasiSandiController.text) {
        final response = await apiService.registerUser(Pengguna(
          email: _emailController.text,
          username: _namaPenggunaController.text,
          password: _kataSandiController.text,
          name: _namaLengkapController.text,
          phone: '0811',
        ));

        if (response['success']) {
          print('Registration successful');
          Navigator.pushNamed(context, '/sign_in');
        } else {
          print('Registration failed');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/background.png", fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 130),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: const Color(0x90BADBFA),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nama Lengkap',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4583DF),
                                      ),
                                    ),
                                    TextField(
                                      controller: _namaLengkapController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4583DF),
                                      ),
                                    ),
                                    TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Nama Pengguna',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4583DF),
                                      ),
                                    ),
                                    TextField(
                                      controller: _namaPenggunaController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Kata Sandi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4583DF),
                                      ),
                                    ),
                                    TextField(
                                      controller: _kataSandiController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Konfirmasi Kata Sandi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4583DF),
                                      ),
                                    ),
                                    TextField(
                                      controller: _konfirmasiSandiController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isAgreed,
                                          onChanged: (value) {
                                            setState(() {
                                              isAgreed = !isAgreed;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Saya setuju dengan syarat dan ketentuan',
                                          style: TextStyle(
                                              color: Color(0xFF0360A3),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _signUp();
                                        },
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                            const Size(340, 60),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFF5D9EFF)),
                                        ),
                                        child: const Text(
                                          'DAFTAR',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Sudah Punya Akun? '),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignInScreen(),
                                                ));
                                          },
                                          child: const Text(
                                            'Masuk',
                                            style: TextStyle(
                                              color: Color(0xFF0B5BA5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF49A2F4),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 60),
                            child: const Text(
                              'DAFTAR',
                              style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
