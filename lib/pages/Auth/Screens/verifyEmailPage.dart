import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/Auth/Screens/sign_in.dart';
import 'package:flutter_grocery_delivery_app/pages/main_page.dart';
import 'package:flutter_grocery_delivery_app/providers/verifyEmailProvider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../services/constants.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  late VerifyEmailProvider verifyEmailProvider;

  @override
  void initState() {
    verifyEmailProvider =
        Provider.of<VerifyEmailProvider>(context, listen: false);
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    ScaffoldMessenger.of(context).showSnackBar(
        red_snackBar("Already verification Email Sent to Your Email."));

    if (!isEmailVerified) {
      verifyEmailProvider.sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3),
          (timer) => verifyEmailProvider.checkEmailVerification());
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    verifyEmailProvider = Provider.of<VerifyEmailProvider>(context);
    return isEmailVerified
        ? MainPage()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Verify Email",
                style: TextStyle(
                    fontFamily: "Circular",
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // GestureDetector(
                    //   onTap: (() => Navigator.pop(context)),
                    //   child: Icon(
                    //     CupertinoIcons.arrow_left,
                    //     color: Colors.black,
                    //     size: 20,
                    //   ),
                    // ),
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        height: 240,
                        width: 250,
                        child: Lottie.asset("assets/lottie/verifyemail.json"),
                      ),
                    ),
                    SizedBox(height: 30),
                    const Text(
                      "Verify Email",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "CircularStd",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   "Email",
                    //   style: TextStyle(
                    //       fontSize: 30,
                    //       fontFamily: "CircularStd",
                    //       color: Colors.black87,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: 15),
                    Text(
                      "A verification Email has neen sent to your Email.",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "CircularStd",
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(137, 0, 0, 0),
                      ),
                    ),

                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          canResendEmail
                              ? {
                                  verifyEmailProvider.sendVerificationEmail(),
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      red_snackBar(
                                          "Verification Email Sent to Your Email."))
                                }
                              : null;
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 3, 127, 228),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Resent Email",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)),
                        onPressed: () {
                          if (isEmailVerified) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                green_snackBar("SignUp Successfully"));
                          }
                          FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return SignIn();
                              })));
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 24),
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
