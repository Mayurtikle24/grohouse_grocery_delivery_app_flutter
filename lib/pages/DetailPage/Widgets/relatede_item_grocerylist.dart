import 'package:flutter/material.dart';

import '../../../model/product_model.dart';

class RelatedItemCardWidget extends StatelessWidget {
  const RelatedItemCardWidget({
    Key? key,
    required this.grocery,
  }) : super(key: key);
  final ProductModel grocery;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 100,
      width: 240,
      decoration: BoxDecoration(
          // color: grocery.bgcolor,
          borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomRight: Radius.circular(15),
      )),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Image.asset(
              grocery.img,
              height: 70,
              width: 90,
            ),
          ),
          Positioned(
            top: 20,
            left: 115,
            child: Text(
              grocery.title,
              style: TextStyle(
                  fontFamily: "Lora",
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
          Positioned(
            top: 48,
            left: 120,
            child: Text(
              "\u20B9 " + "${grocery.price}",
              style: TextStyle(
                  fontFamily: "Lora",
                  decoration: TextDecoration.none,
                  fontSize: 16,
                  color: Color.fromARGB(221, 74, 72, 72)),
            ),
          ),
          Positioned(
            left: 195,
            top: 70,
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(30)),
              ),
              child: GestureDetector(
                  child: Icon(
                Icons.add,
              )),
            ),
          )
        ],
      ),
    );
  }
}
