import 'package:flutter/material.dart';

import 'package:flutter_grocery_delivery_app/model/product_model.dart';

class CategoryListTitleWidget extends StatelessWidget {
  const CategoryListTitleWidget({
    Key? key,
    required this.categories,
    required this.index,
  }) : super(key: key);
  final CategoriesModel categories;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          categories.title,
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 13, fontFamily: "Lora", color: Colors.black),
        ),
      ),
    );
  }
}
