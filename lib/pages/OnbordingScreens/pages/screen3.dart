// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnbordingPage3 extends StatelessWidget {
  const OnbordingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Center(
              child: Lottie.asset("assets/lottie/onlineDelivery.json",
                  height: 500, width: 300),
            ),
            const Text(
              "Fast Doorstep Deliveries",
              style: const TextStyle(
                  fontSize: 25,
                  fontFamily: "Circular",
                  color: const Color.fromARGB(255, 4, 55, 96),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Our delivey executive will deliver your\n               order in under 24 hours",
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
    ;
  }
}
