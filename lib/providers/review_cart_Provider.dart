import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_grocery_delivery_app/model/product_model.dart';
import 'package:flutter_grocery_delivery_app/model/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  List<ReviewCartModel> reviewCartDataList = [];

//Adding Review Cart Data to Firebase.

  void addReviewCartData({
    required String CartId,
    required String CartTitle,
    required String CartImg,
    required int CartPrice,
    required var CartUnit,
    // required String CartUnit,
    required int CartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(CartId)
        .set({
      "cartId": CartId,
      "cartTitle": CartTitle,
      "cartImage": CartImg,
      "cartPrice": CartPrice,
      "cartUnit": CartUnit,
      "cartQuantity": CartQuantity,
      "isAdd": true
    });
  }

//Updating  Review Cart Data to Firebase.

  void updateReviewCartData({
    required String CartId,
    required String CartTitle,
    required String CartImg,
    required int CartPrice,

    // required var CartUnit,
    required int CartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(CartId)
        .update({
      "cartId": CartId,
      "cartTitle": CartTitle,
      "cartImage": CartImg,
      "cartPrice": CartPrice,
      "cartQuantity": CartQuantity,
      "isAdd": true
    });
  }

//Feaching Review Cart Data to Firebase.

  getReviewCartData() async {
    List<ReviewCartModel> newreviewCartDataList = [];
    QuerySnapshot reviewCartValues = await FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .get();

    reviewCartValues.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
          CartId: element.get("cartId"),
          CartTitle: element.get("cartTitle"),
          CartImg: element.get("cartImage"),
          CartPrice: element.get("cartPrice"),
          CartUnit: element.get("cartUnit"),
          CartQuantity: element.get("cartQuantity"));
      newreviewCartDataList.add(reviewCartModel);
    });

    reviewCartDataList = newreviewCartDataList;
    notifyListeners();
  }

  List<ReviewCartModel> get getreviewCartDataList {
    return reviewCartDataList;
  }

  /// Total Price
  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += element.CartPrice * element.CartQuantity;
    });
    return total;
  }

//Deleting Review Cart Data to Firebase.

  reviewCartItemDelete(cartId) {
    FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  reviewCartDeleteAll() {
    FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
