import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'sign_in.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: (() => Navigator.pop(context)),
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Container(
                  height: 240,
                  width: 250,
                  child: Lottie.asset("assets/lottie/password.json"),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "CircularStd",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "CircularStd",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "New Password",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 152, 149, 149)),
                      prefixIcon: Icon(
                        CupertinoIcons.lock,
                        size: 22,
                      ),
                      suffixIcon: Icon(
                        CupertinoIcons.eye_slash_fill,
                        size: 20,
                      ))),
              Container(
                margin: EdgeInsets.only(left: 50),
                height: 1,
                width: 270,
                color: Color.fromARGB(255, 218, 212, 212),
              ),
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Confirm new Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 152, 149, 149)),
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          size: 22,
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.eye_slash_fill,
                          size: 20,
                        ))),
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                height: 1,
                width: 270,
                color: Color.fromARGB(255, 218, 212, 212),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignIn();
                    }));
                  }),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 3, 127, 228),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
