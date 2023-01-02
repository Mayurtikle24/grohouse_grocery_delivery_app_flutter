import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Theme/themeProvider.dart';

class ProductUnitWidget extends StatelessWidget {
  ProductUnitWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    return Container(
      height: 20,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(255, 42, 71, 116),
              width: 0.6,
              style: BorderStyle.solid),
          color: themeProvider.isDarkMode ? Colors.indigo[300] : Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 1,
              left: 5,
              child: Text(
                "${title}",
                style: TextStyle(
                    fontSize: 13, color: textColor, fontFamily: "Lora"),
              ),
            ),
            Positioned(
                left: 50,
                top: -4,
                child: Icon(Icons.arrow_drop_down,
                    size: 25,
                    color: themeProvider.isDarkMode
                        ? Colors.amber[400]
                        : Colors.black87))
          ],
        ),
      ),
    );
  }
}
