import 'package:flutter/material.dart';

class DrawerItems extends StatelessWidget {
  String icon;
  String title;
  DrawerItems({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          child: Image.asset(icon),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontFamily: "Lora",
              decoration: TextDecoration.none),
        )
      ],
    );
  }
}
