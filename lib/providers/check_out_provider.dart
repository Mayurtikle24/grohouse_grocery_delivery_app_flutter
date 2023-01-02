import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_grocery_delivery_app/model/delivery_Detail_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

import 'package:flutter_grocery_delivery_app/pages/Delivery_Details_Page/add_delivery_detailsPage.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoading = false;
  TextEditingController firstNameTextEditingController =
      new TextEditingController();
  TextEditingController lastNameTextEditingController =
      new TextEditingController();
  TextEditingController phoneTextEditingController =
      new TextEditingController();
  TextEditingController societyTextEditingController =
      new TextEditingController();
  TextEditingController streetTextEditingController =
      new TextEditingController();
  TextEditingController landmarkTextEditingController =
      new TextEditingController();
  TextEditingController cityTextEditingController = new TextEditingController();
  TextEditingController areaTextEditingController = new TextEditingController();
  TextEditingController pincodeTextEditingController =
      new TextEditingController();

  LocationData? setLocation;

  void validator(context, AddressType addressType) async {
    if (firstNameTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "First Name field is Empty");
    } else if (lastNameTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Last Name field is Empty");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone number field is Empty");
    } else if (societyTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Society field is Empty");
    } else if (streetTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street field is Empty");
    } else if (landmarkTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmart field is Empty");
    } else if (cityTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "City field is Empty");
    } else if (areaTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area field is Empty");
    } else if (pincodeTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Pincode field is Empty");
    } else if (setLocation == null) {
      Fluttertoast.showToast(msg: "set Location field is Empty");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("Delivery Details")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": firstNameTextEditingController.text,
        "lastName": lastNameTextEditingController.text,
        "phone": phoneTextEditingController.text,
        "society": societyTextEditingController.text,
        "street": streetTextEditingController.text,
        "landmark": landmarkTextEditingController.text,
        "city": cityTextEditingController.text,
        "area": areaTextEditingController.text,
        "pincode": pincodeTextEditingController.text,
        "addressType": addressType.toString(),
        "latitude": setLocation?.latitude,
        "longitude": setLocation?.longitude
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add Your Delivery Details");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryDetailModel> deliveryDetailsList = [];
  getDeliveryDetailsData() async {
    List<DeliveryDetailModel> newList = [];
    DeliveryDetailModel? deliveryDetailModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("Delivery Details")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (_db.exists) {
      deliveryDetailModel = DeliveryDetailModel(
          firstName: _db.get("firstName"),
          lastName: _db.get("lastName"),
          phone: _db.get("phone"),
          society: _db.get("society"),
          street: _db.get("street"),
          landMark: _db.get("landmark"),
          city: _db.get("city"),
          area: _db.get("area"),
          pincode: _db.get("pincode"),
          addressType: _db.get("addressType"));
      newList.add(deliveryDetailModel);
      notifyListeners();
    }
    deliveryDetailsList = newList;
    notifyListeners();
  }

  List<DeliveryDetailModel> get getDeliveryDetailsList {
    return deliveryDetailsList;
  }
}
