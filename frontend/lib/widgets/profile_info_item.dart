import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;
  final Color color;

  const ProfileInfoItem({super.key,
    required this.icon,
    this.label = '',
    required this.value,
    this.showEditIcon = false,
    this.onEditPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(icon, color: color),
                SizedBox(width: 8,),
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                )
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: Text('$value',
        //     style: const TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold),
        //   ),),
        if(showEditIcon) InkWell(onTap: onEditPressed, child: Icon(Icons.edit))
      ],
    );
  }
}
