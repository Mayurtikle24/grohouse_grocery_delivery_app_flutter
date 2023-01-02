import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_grocery_delivery_app/pages/main_page.dart';
import 'package:flutter_grocery_delivery_app/providers/review_cart_Provider.dart';

import '../../Theme/themeProvider.dart';

class SuccessfulPayment extends StatefulWidget {
  SuccessfulPayment({Key? key, required this.title, required this.total})
      : super(key: key);
  final String title;
  var total;
  @override
  State<SuccessfulPayment> createState() => _SuccessfulPaymentState();
}

class _SuccessfulPaymentState extends State<SuccessfulPayment> {
  late ReviewCartProvider reviewCartProvider;

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MainPage();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 210,
              left: 10,
              child: Lottie.asset("assets/lottie/10470-confirm.json",
                  height: 300, width: MediaQuery.of(context).size.width),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Center(
                child: Text(
                  "${widget.title}",
                  style: TextStyle(
                      fontFamily: "Circular", fontSize: 25, color: textColor),
                ),
              ),
            ),
            Positioned(
              top: 470,
              left: 30,
              child: Text(
                "Your Order was Placed Successfully",
                style: TextStyle(
                    fontFamily: "Circular", fontSize: 20, color: textColor),
              ),
            ),
            Positioned(
                top: 495,
                left: 145,
                child: Text(
                  "\u20B9" "${widget.total}",
                  style: TextStyle(
                      fontFamily: "Circular",
                      fontSize: 30,
                      color: themeProvider.isDarkMode
                          ? Colors.amber
                          : Colors.black,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ));
  }
}
