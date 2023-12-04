import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomNavigationBar(
      {super.key, required this.onItemSelected, required this.selectedIndex});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(Icons.home, Icons.home_outlined, 0, 'home'),
          navItem(Icons.favorite, Icons.favorite_border, 1, 'favorite'),
          navItem(Icons.airplane_ticket, Icons.airplane_ticket_outlined, 2,
              'order'),
          navItem(Icons.person, Icons.person_outline, 3, 'profile'),
        ],
      ),
    );
  }

  Widget navItem(
      IconData icon, IconData borderIcon, int index, String routeName) {
    return IconButton(
      icon: Icon(
        widget.selectedIndex == index ? icon : borderIcon,
        color: widget.selectedIndex == index ? Colors.blue : Colors.black26,
      ),
      onPressed: () {
        widget.onItemSelected(index);
        if (widget.selectedIndex != index) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/$routeName',
            (route) => false,
          );
        }
      },
      highlightColor: Colors.transparent,
    );
  }
}
