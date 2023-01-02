import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/OnbordingScreens/pages/screen1.dart';
import 'package:flutter_grocery_delivery_app/pages/OnbordingScreens/pages/screen2.dart';
import 'package:flutter_grocery_delivery_app/pages/OnbordingScreens/pages/screen3.dart';
import 'package:flutter_grocery_delivery_app/pages/OnbordingScreens/pages/screen4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Auth/Screens/sign_in.dart';

class OnbordingScreen extends StatefulWidget {
  OnbordingScreen({Key? key}) : super(key: key);

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  PageController _controller = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 3);
              });
            },
            children: [
              OnbordingPage1(),
              OnbordingPage2(),
              OnbordingPage3(),
              OnbordingPage4()
            ],
          ),
          Positioned(
            top: 700,
            left: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: (() {
                  _controller.jumpToPage(3);
                }),
                child: const Center(
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontFamily: "Circular",
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          isLastPage
              ? Positioned(
                  top: 700,
                  left: 290,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return SignIn();
                        }));
                      },
                      child: const Center(
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Circular",
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: 700,
                  left: 290,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: (() {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Circular",
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
          Container(
              alignment: Alignment(0, 0.830),
              child: SmoothPageIndicator(controller: _controller, count: 4)),
        ],
      ),
    );
  }
}
