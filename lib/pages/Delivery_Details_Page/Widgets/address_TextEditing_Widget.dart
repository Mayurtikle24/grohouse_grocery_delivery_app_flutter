import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Theme/themeProvider.dart';

class AddressTextEditingWidget extends StatelessWidget {
  String title;
  TextEditingController controller;
  String hintText;
  IconData iconData;

  AddressTextEditingWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: textColor, fontSize: 16),
          ),
          SizedBox(height: 7),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeProvider.isDarkMode
                    ? Colors.blue[50]
                    : Color.fromARGB(255, 214, 228, 240)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      iconData,
                      color: Colors.black,
                    ),
                    hintText: "$hintText",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: 15,
                        color: themeProvider.isDarkMode
                            ? Colors.black54
                            : Color.fromARGB(255, 152, 149, 149)),
                  )),
            ),
          ),
          SizedBox(height: 7),
        ],
      ),
    );
  }
}
