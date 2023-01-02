import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_grocery_delivery_app/model/product_model.dart';

class WishListProvider with ChangeNotifier {
  void addWishListData({
    required String wishListId,
    required String wishListTitle,
    required String wishListImg,
    required int wishListPrice,
    required List<dynamic> wishListUnit,
    required int wishListQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .set({
      "wishListId": wishListId,
      "wishListTitle": wishListTitle,
      "wishListImage": wishListImg,
      "wishListPrice": wishListPrice,
      "wishListUnit": wishListUnit,
      "wishListQuantity": wishListQuantity,
      "wishList": true
    });
  }

  List<ProductModel> wishListProductList = [];
  getWishListData() async {
    List<ProductModel> wishListData = [];
    QuerySnapshot wishList = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();

    wishList.docs.forEach((element) {
      ProductModel productModel = ProductModel(
          id: element.get("wishListId"),
          title: element.get("wishListTitle"),
          img: element.get("wishListImage"),
          price: element.get("wishListPrice"),
          unit: element.get("wishListUnit"),
          quantity: element.get("wishListQuantity"));
      wishListData.add(productModel);
    });
    wishListProductList = wishListData;
    notifyListeners();
  }

  List<ProductModel> get getWishlistData {
    return wishListProductList;
  }

  deleteWishList(wishListId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
  }
}
