import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/themeProvider.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 3, 46, 82)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "FAQ",
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.normal,
              fontFamily: "Circular"),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.arrow_left,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
