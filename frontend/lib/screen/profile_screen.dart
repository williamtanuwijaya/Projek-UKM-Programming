import 'package:flutter/material.dart';
import 'package:ukm_project/widgets/custom_navigation_bar.dart';
import 'package:ukm_project/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f8fe),
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              radius: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Informasi Akun',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10),
                  ProfileInfoItem(
                        icon: Icons.account_circle_outlined,
                        value: 'Mbak IU',
                        color: Colors.blueAccent
                    ),
                  SizedBox(height: 10),
                  ProfileInfoItem(
                      icon: Icons.mail_outline_outlined,
                      value: 'MbakIU@gmail.com',
                      color: Colors.blueAccent
                  ),
                  SizedBox(height: 10),
                  ProfileInfoItem(
                      icon: Icons.phone_outlined,
                      value: '+628xxxxxxxxxx',
                      color: Colors.blueAccent
                  ),
                  SizedBox(height: 10),
                  ProfileInfoItem(
                      icon: Icons.lock_outlined,
                      value: '****',
                      color: Colors.blueAccent
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Detail Informasi',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10),
                  ProfileInfoItem(
                      icon: Icons.logout_outlined,
                      value: 'Keluar',
                      color: Colors.blueAccent
                  ),
                  SizedBox(height: 10),
                  ProfileInfoItem(
                      icon: Icons.wallet_outlined,
                      value: 'WanderPay',
                      color: Colors.blueAccent
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onItemSelected: (index) {
          _selectedIndex = index;
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
