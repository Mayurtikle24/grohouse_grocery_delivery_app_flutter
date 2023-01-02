import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/colors.dart';

import 'package:flutter_grocery_delivery_app/model/product_model.dart';
import 'package:provider/provider.dart';

import '../../../Theme/themeProvider.dart';

class CategoryCardUI extends StatelessWidget {
  CategoriesModel category;

  CategoryCardUI({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Color.fromARGB(255, 228, 40, 26)
        : Color.fromARGB(255, 16, 81, 134);
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 140,
      width: 130,
      decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkProductCard : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 20,
              width: 80,
              decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Colors.black
                      : Color.fromARGB(255, 54, 6, 113),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Center(
                child: Text(
                  "Up to ${category.discount}% OFF",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.amber
                          : Colors.white,
                      fontSize: 11,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          Positioned(
            left: 27,
            top: 30,
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider("${category.img}",
                        scale: 1)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Text(
                "${category.title}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Circular"),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
