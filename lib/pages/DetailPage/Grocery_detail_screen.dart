// ignore_for_file: unnecessary_const

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/colors.dart';
import 'package:flutter_grocery_delivery_app/providers/productProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_grocery_delivery_app/pages/DetailPage/Widgets/bottomNavWidget.dart';
import 'package:flutter_grocery_delivery_app/pages/ReviewCart/review_cart.dart';
import 'package:flutter_grocery_delivery_app/providers/wishList_provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/constants.dart';
import '../../services/internet_service.dart';
import '../../services/noInternetWidget.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({
    Key? key,
    required this.id,
    required this.img,
    required this.title,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.desc,
  }) : super(key: key);

  final String id;
  final String img;
  final String title;
  final int price;
  final int quantity;
  var unit;
  // final String unit;
  final String desc;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final added_snackBar = SnackBar(
    content: Text("Added to Cart"),
    backgroundColor: Color.fromARGB(255, 8, 137, 75),
    duration: Duration(seconds: 2),
    action: SnackBarAction(label: "Undo", onPressed: () {}),
  );
  final removed_snackBar = SnackBar(
    content: Text("Removed From Cart"),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
    action: SnackBarAction(label: "Undo", onPressed: () {}),
  );

  bool wishListBool = false;

  getWishListStatus() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(widget.id)
        .get()
        .then((value) {
      if (this.mounted) {
        if (value.exists) {
          setState(() {
            wishListBool = value.get("wishList");
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider _wishListProvider = Provider.of<WishListProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    var networkStatus = Provider.of<NetworkStatus>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    Color productDetailColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 74, 72, 72);
    getWishListStatus();
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Colors.white,
        bottomNavigationBar: networkStatus == NetworkStatus.Offline
            ? NoInternetWidget()
            : Row(
                children: [
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        wishListBool = !wishListBool;
                      });
                      if (wishListBool == true) {
                        _wishListProvider.addWishListData(
                            wishListId: widget.id,
                            wishListTitle: widget.title,
                            wishListImg: widget.img,
                            wishListPrice: widget.price,
                            wishListUnit: widget.unit,
                            wishListQuantity: widget.quantity);
                      } else {
                        _wishListProvider.deleteWishList(widget.id);
                      }
                    }),
                    child: BoottomNavWidget(
                        color: Colors.black87,
                        iconColor: wishListBool
                            ? Color.fromARGB(255, 188, 36, 25)
                            : Colors.grey,
                        textColor: Colors.white,
                        title: "Add to Wishlist",
                        icon: wishListBool
                            ? Icons.favorite
                            : Icons.favorite_outline),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Review_Cart_Page();
                    })),
                    child: BoottomNavWidget(
                        color: Color.fromARGB(255, 222, 183, 57),
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        title: "Go to Cart",
                        icon: Icons.shop_outlined),
                  )
                ],
              ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.pop(context)),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return Review_Cart_Page();
                      })),
                      child: Container(
                        height: 30,
                        child: Image.asset("assets/icons/basket.png"),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  child: Hero(
                    tag: "productImage",
                    child: CachedNetworkImage(
                      imageUrl: "${widget.img}",
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 43),
                child: Container(
                  height: 349,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? darkProductCard
                          : Color.fromARGB(255, 221, 245, 222),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontFamily: "Lora",
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeProvider.isDarkMode
                                        ? Color.fromARGB(255, 255, 40, 24)
                                        : Colors.black),
                              ),
                            
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "\u20B9",
                              style: TextStyle(color: textColor, fontSize: 14),
                            ),
                            Text(
                              "${widget.price}",
                              style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.amber
                                      : Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Important Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 160,
                          width: 340,
                          child: Text(
                            ProductDetail,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 13,
                                letterSpacing: 0.8,
                                height: 1.5,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Circular-light",
                                color: productDetailColor),
                          ),
                        ),

                        // SizedBox(height: 10),
                        // RealatedItemListView(),
                        // SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
