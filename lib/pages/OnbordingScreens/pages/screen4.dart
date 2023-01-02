import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/Location/location_screen.dart';
import 'package:flutter_grocery_delivery_app/providers/location_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../services/internet_service.dart';
import '../../Auth/Screens/sign_in.dart';

class OnbordingPage4 extends StatefulWidget {
  OnbordingPage4({Key? key}) : super(key: key);

  @override
  State<OnbordingPage4> createState() => _OnbordingPage4State();
}

class _OnbordingPage4State extends State<OnbordingPage4> {
  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    final _locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Lottie.asset("assets/lottie/deliverylocation.json",
                height: 400, width: MediaQuery.of(context).size.width),
            Text(
              "Set your Location",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Circular",
                  color: Color.fromARGB(255, 4, 55, 96),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                "allow the app to access your current location \n and choose anything you want from the store",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Circular",
                    color: Color.fromARGB(255, 139, 141, 142),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                "Ready to order from your nearest Shop?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Circular",
                    color: Color.fromARGB(255, 8, 78, 113),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            networkStatus == NetworkStatus.Online
                ? GestureDetector(
                    onTap: () async {
                      print(_locationProvider.setLocation);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LocationScreen();
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 3, 127, 228),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Set Delivery Location",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 3, 127, 228),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Check Your Connection",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already a Customer? ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return SignIn();
                    }));
                  },
                  child: const Text(
                    "LogIn",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 119, 214)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
