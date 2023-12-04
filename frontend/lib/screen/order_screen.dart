import 'package:flutter/material.dart';
import 'package:ukm_project/widgets/custom_navigation_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        onItemSelected: (index) {
          _selectedIndex = index;
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
