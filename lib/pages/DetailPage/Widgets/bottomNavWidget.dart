import 'package:flutter/material.dart';

class BoottomNavWidget extends StatelessWidget {
  Color color;
  Color iconColor;
  String title;
  Color textColor;
  IconData icon;
  BoottomNavWidget({
    Key? key,
    required this.color,
    required this.iconColor,
    required this.title,
    required this.textColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 180,
        padding: EdgeInsets.all(20),
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(color: textColor, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
