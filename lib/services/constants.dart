import 'package:flutter/material.dart';

const ApiKey = "AIzaSyBbPDArkNm9yL_pza6pZedhW8H1GWFZTvk";
const ProductDetail =
    "The product images(s) shown are for representation purposes only.The actual product may vary.It is recommended to read the product lables (if any),batch detail, directions for use,etc., as contained in the actual product before consuming and/or utilizing the product. The product is meant for fresh and immediate consumption, or as specified by the seller of the product. For other information, please contact the merchant directly.";

red_snackBar(message) {
  return SnackBar(
    content: Text("${message}"),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
  );
}

green_snackBar(message) {
  return SnackBar(
    content: Text("${message}"),
    backgroundColor: Color.fromARGB(255, 8, 137, 75),
    duration: Duration(seconds: 2),
  );
}

enum ConnectivityStatus { WiFi, Cellular, Offline }
