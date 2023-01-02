import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/providers/productProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_grocery_delivery_app/providers/review_cart_Provider.dart';

import '../../../Theme/themeProvider.dart';
import '../../../services/constants.dart';

class ProductCounterWidget extends StatefulWidget {
  final String ProductId;
  final String ProductTitle;
  final String Productimg;
  final int Productprice;
  var Productunit;
 

  ProductCounterWidget({
    Key? key,
    required this.ProductId,
    required this.ProductTitle,
    required this.Productimg,
    required this.Productprice,
    required this.Productunit,
  }) : super(key: key);

  @override
  State<ProductCounterWidget> createState() => _ProductCounterWidgetState();
}

class _ProductCounterWidgetState extends State<ProductCounterWidget> {
  int quantity = 1;
  bool isAdded = false;

  getAddAndQuantity(productQuantity) {
    FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.ProductId)
        .get()
        .then((value) {
      if (this.mounted) {
        if (value.exists) {
          setState(() {
            quantity = value.get("cartQuantity");
            isAdded = value.get("isAdd");
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(255, 53, 189, 57);
    Color buttonColor = themeProvider.isDarkMode
        ? Color.fromARGB(255, 15, 95, 161)
        : Colors.white;
    getAddAndQuantity(quantity);
    ReviewCartProvider _reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Positioned(
      top: 180,
      left: 80,
      child: isAdded
          ? Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (quantity == 1) {
                        setState(() {
                          isAdded = false;
                        });
                        Fluttertoast.showToast(
                            msg: "Your Reached Minimum Limits",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue[900],
                            textColor: Colors.white,
                            fontSize: 12.0);
                        _reviewCartProvider
                            .reviewCartItemDelete(widget.ProductId);
                      } else if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });

                        _reviewCartProvider.updateReviewCartData(
                          CartId: widget.ProductId,
                          CartTitle: widget.ProductTitle,
                          CartImg: widget.Productimg,
                          CartPrice: widget.Productprice,
                          CartQuantity: quantity,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            red_snackBar("Item removed from Cart"));
                      }
                    },
                    child: Container(
                      height: 20,
                      width: 22,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 23, 96, 155),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                      width: 20,
                      child: Center(
                        child: Text(
                          "${quantity}",
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 17),
                        ),
                      )),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      if (quantity < 10) {
                        setState(() {
                          quantity++;
                        });

                        _reviewCartProvider.updateReviewCartData(
                          CartId: widget.ProductId,
                          CartTitle: widget.ProductTitle,
                          CartImg: widget.Productimg,
                          CartPrice: widget.Productprice,
                          CartQuantity: quantity,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(green_snackBar("Added Item to Cart"));
                      } else if (quantity == 10) {
                        Fluttertoast.showToast(
                            msg: "You Reached Maximum Limits",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue[900],
                            textColor: Colors.white,
                            fontSize: 12.0);
                      }
                    },
                    child: Container(
                      height: 20,
                      width: 22,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 23, 96, 155),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  isAdded = true;
                });

                _reviewCartProvider.addReviewCartData(
                  CartId: widget.ProductId,
                  CartTitle: widget.ProductTitle,
                  CartImg: widget.Productimg,
                  CartPrice: widget.Productprice,
                  CartUnit: widget.Productunit,
                  // CartUnit: widget.Productunit,
                  CartQuantity: quantity,
                );
                ScaffoldMessenger.of(context)
                    .showSnackBar(green_snackBar("Added Item to Card"));
              },
              child: Container(
                height: 32,
                width: 65,
                decoration: BoxDecoration(
                    color: buttonColor,
                    border: Border.all(
                        color: Color.fromARGB(255, 53, 189, 57),
                        width: 0.7,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 17,
                      color: textColor,
                    ),
                    Text(
                      "Add",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontFamily: "Circular",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
