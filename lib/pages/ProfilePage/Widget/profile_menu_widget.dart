import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Theme/themeProvider.dart';

class ProfileMenuItems extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileMenuItems({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 72,
      width: 370,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 40, left: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        gradient: LinearGradient(colors: [
                          themeProvider.isDarkMode
                              ? Colors.amber.withOpacity(0.5)
                              : Colors.black.withOpacity(0.3),
                          themeProvider.isDarkMode
                              ? Colors.amber.withOpacity(0.8)
                              : Colors.black.withOpacity(0.6),
                          themeProvider.isDarkMode
                              ? Colors.amber.withOpacity(0.9)
                              : Colors.black.withOpacity(0.9)
                        ]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      icon,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: "Lora",
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Color.fromARGB(221, 59, 58, 58)),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 19,
                color: themeProvider.isDarkMode ? Colors.orange : Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
