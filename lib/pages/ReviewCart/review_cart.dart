import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/colors.dart';
import 'package:flutter_grocery_delivery_app/model/review_cart_model.dart';
import 'package:flutter_grocery_delivery_app/pages/Delivery_Details_Page/delivery_detail_Page.dart';
import 'package:flutter_grocery_delivery_app/pages/DetailPage/Grocery_detail_screen.dart';
import 'package:flutter_grocery_delivery_app/pages/ReviewCart/product_cart_item.dart';
import 'package:flutter_grocery_delivery_app/providers/review_cart_Provider.dart';
import 'package:flutter_grocery_delivery_app/services/noInternetWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/internet_service.dart';

class Review_Cart_Page extends StatelessWidget {
  late ReviewCartProvider _reviewCartProvider;
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

  showDialog(BuildContext context, ReviewCartModel delete) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Review Cart"),
          content: Text("Are you sure you want to delete the Product?"),
          actions: [
            CupertinoDialogAction(
                child: Text("YES"),
                onPressed: () {
                  _reviewCartProvider.reviewCartItemDelete(delete.CartId);
                  Navigator.pop(context);
                }),
            CupertinoDialogAction(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    var networkStatus = Provider.of<NetworkStatus>(context);
    _reviewCartProvider.getReviewCartData();
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? backroundColor : Colors.white,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? backroundColor : Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          " Review Cart",
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
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      bottomNavigationBar: _reviewCartProvider.reviewCartDataList.isEmpty
          ? Center(
              child: Lottie.asset("assets/lottie/shake_empty_box.json",
                  height: 500, width: MediaQuery.of(context).size.width),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: networkStatus == NetworkStatus.Offline
                  ? NoInternetWidget()
                  : Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text("Total Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 19)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 55),
                                  child: Text(
                                      "\u20B9 ${_reviewCartProvider.getTotalPrice()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Circular",
                                          color: themeProvider.isDarkMode
                                              ? Colors.amber[600]
                                              : Color.fromARGB(
                                                  255, 18, 79, 132),
                                          fontSize: 22)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return DeliveryDetailPage();
                                }));
                              },
                              child: Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 15, 102, 173),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: "Circular",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
      body: networkStatus == NetworkStatus.Offline
          ? NoInternetWidget()
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _reviewCartProvider.getreviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel cartItem =
                    _reviewCartProvider.getreviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailScreen(
                              id: cartItem.CartId,
                              img: cartItem.CartImg,
                              title: cartItem.CartTitle,
                              price: cartItem.CartPrice,
                              quantity: cartItem.CartQuantity,
                              unit: cartItem.CartUnit,
                              desc: "");
                        }));
                      },
                      child: ProductCardItem(
                          id: cartItem.CartId,
                          img: cartItem.CartImg,
                          wishList: false,
                          price: cartItem.CartPrice,
                          quantity: cartItem.CartQuantity,
                          unit: cartItem.CartUnit,
                          title: cartItem.CartTitle,
                          onDelete: () => showDialog(context, cartItem)),
                    )
                  ],
                );
              }),
    );
  }
}
