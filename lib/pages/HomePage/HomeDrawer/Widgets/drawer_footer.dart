import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Auth/Screens/sign_in.dart';

class DrawerFooterWidget extends StatelessWidget {
  const DrawerFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            height: 20,
            width: 2,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn())));
            },
            child: const Text(
              "Log out",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lora",
                  decoration: TextDecoration.none,
                  fontSize: 17,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
