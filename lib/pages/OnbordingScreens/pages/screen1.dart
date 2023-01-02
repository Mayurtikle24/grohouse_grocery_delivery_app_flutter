import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnbordingPage1 extends StatelessWidget {
  const OnbordingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Lottie.asset("assets/lottie/onbording1.json",
                height: 500, width: MediaQuery.of(context).size.width),
            const Text(
              "Need Groceries Now?",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Circular",
                  color: Color.fromARGB(255, 4, 55, 96),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Select wide range of products from \n fresh groceries to delicious snacks",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Circular",
                  color: Color.fromARGB(255, 139, 141, 142),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
