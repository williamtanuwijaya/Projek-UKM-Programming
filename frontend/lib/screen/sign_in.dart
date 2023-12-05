import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _namaPenggunaController = TextEditingController();
  final TextEditingController _kataSandiController = TextEditingController();

  bool isRemembered = false;

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
                              padding: const EdgeInsets.only(top: 230),
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
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isRemembered,
                                          onChanged: (value) {
                                            setState(() {
                                              isRemembered = !isRemembered;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Ingat saya',
                                          style: TextStyle(
                                              color: Color(0xFF0360A3),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 160),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                            const Size(340, 60),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFF5D9EFF)),
                                        ),
                                        child: const Text(
                                          'MASUK',
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
                                        const Text('Lupa Kata Sandi? '),
                                        InkWell(
                                          onTap: () {},
                                          child: const Text(
                                            'Lupa Password',
                                            style: TextStyle(
                                              color: Color(0xFF0B5BA5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Tidak Punya Akun? '),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Daftar',
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
                              'MASUK',
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
