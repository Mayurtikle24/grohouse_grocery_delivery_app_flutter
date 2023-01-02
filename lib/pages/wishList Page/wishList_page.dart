import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/model/product_model.dart';
import 'package:flutter_grocery_delivery_app/pages/DetailPage/Grocery_detail_screen.dart';
import 'package:flutter_grocery_delivery_app/providers/wishList_provider.dart';
import 'package:flutter_grocery_delivery_app/services/noInternetWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/internet_service.dart';
import 'wishListcart_item.dart';

class FavouritePage extends StatelessWidget {
  late WishListProvider wishListProvider;

  final removed_snackBar = SnackBar(
    content: Text("Removed From WishList"),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
  );
  showDialog(BuildContext context, ProductModel delete) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("WishList"),
          content: Text(
              "Are you sure you want to remove the Product from WishList?"),
          actions: [
            CupertinoDialogAction(
                child: Text("YES"),
                onPressed: () {
                  wishListProvider.deleteWishList(delete.id);

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(removed_snackBar);
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
    wishListProvider = Provider.of<WishListProvider>(context);
    var networkStatus = Provider.of<NetworkStatus>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    wishListProvider.getWishListData();
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: themeProvider.isDarkMode
              ? Color.fromARGB(255, 3, 46, 82)
              : Colors.white,
          title: Text(
            "WishList",
            style: TextStyle(color: textColor),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 35,
              width: 35,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Icon(
                CupertinoIcons.arrow_left,
                color: textColor,
              ),
            ),
          ),
        ),
        body: networkStatus == NetworkStatus.Offline
            ? NoInternetWidget()
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: wishListProvider.getWishlistData.isEmpty
                    ? Center(
                        child: networkStatus == NetworkStatus.Offline
                            ? NoInternetWidget()
                            : Lottie.asset("assets/lottie/fav.json",
                                height: 500,
                                width: MediaQuery.of(context).size.width),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: wishListProvider.getWishlistData.length,
                        itemBuilder: (context, index) {
                          ProductModel wishListItem =
                              wishListProvider.getWishlistData[index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ProductDetailScreen(
                                        id: wishListItem.id,
                                        img: wishListItem.img,
                                        title: wishListItem.title,
                                        price: wishListItem.price,
                                        quantity: wishListItem.quantity,
                                        unit: wishListItem.unit,
                                        desc: "");
                                  }));
                                },
                                child: WishListCartWidget(
                                    id: wishListItem.id,
                                    img: wishListItem.img,
                                    wishList: true,
                                    price: wishListItem.price,
                                    quantity: wishListItem.quantity,
                                    unit: wishListItem.unit,
                                    title: wishListItem.title,
                                    onDelete: () =>
                                        showDialog(context, wishListItem)),
                              )
                            ],
                          );
                        }),
              ));
  }
}

