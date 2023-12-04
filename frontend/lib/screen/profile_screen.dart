import 'package:flutter/material.dart';
import 'package:ukm_project/widgets/custom_navigation_bar.dart';

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
      body: const Placeholder(),
      bottomNavigationBar: CustomNavigationBar(
        onItemSelected: (index) {
          _selectedIndex = index;
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
