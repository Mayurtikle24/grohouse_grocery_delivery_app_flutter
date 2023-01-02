import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnbordingPage2 extends StatelessWidget {
  const OnbordingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Lottie.asset("assets/lottie/onbording2.json",
                height: 500, width: MediaQuery.of(context).size.width),
            const Text(
              "Hassle Free Payments",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Circular",
                  color: const Color.fromARGB(255, 4, 55, 96),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Pay as per your convenience,we accept\n   all debit cards and Cash on Delivery.",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Circular",
                  color: const Color.fromARGB(255, 139, 141, 142),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
