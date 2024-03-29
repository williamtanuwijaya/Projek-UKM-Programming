import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ukm_project/screen/favorite_screen.dart';
import 'package:ukm_project/screen/home_screen.dart';
import 'package:ukm_project/screen/order_screen.dart';
import 'package:ukm_project/screen/profile_screen.dart';
import 'package:ukm_project/screen/sign_in.dart';
import 'package:ukm_project/screen/sign_up.dart';

void main() {
  initializeDateFormatting('id_ID', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
      initialRoute: '/',
      routes: {
        '/sign_in': (context) => const SignInScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/favorite': (context) => const FavoriteScreen(),
        '/order': (context) => const OrderScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
