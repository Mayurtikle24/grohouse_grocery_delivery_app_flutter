import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/services/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool isLogin = false;

  Future googleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication goggleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: goggleAuth.accessToken, idToken: goggleAuth.idToken);

      final User? user = (await _auth.signInWithCredential(credential)).user;
      addUserDetails(user!, user.displayName!, user.photoURL!, user.email!);
      return user;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(red_snackBar(e));
    }
    notifyListeners();
  }

  signIn(
    BuildContext context,
    TextEditingController _emailTextEditingController,
    TextEditingController _passwordTextEditingController,
  ) async {
    try {
      if (EmailValidator.validate(_emailTextEditingController.text.trim()) ==
          true) {
        await _auth.signInWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim());
        isLogin = true;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(red_snackBar("Something Went Wrong"));
      isLogin = false;
      notifyListeners();
    }

    notifyListeners();
  }

  void signUp(
      BuildContext context,
      TextEditingController _emailTextEditingController,
      TextEditingController _passwordTextEditingController,
      TextEditingController _conformPasswordTextEditingController) async {
    try {
      if (_passwordTextEditingController.text.trim() ==
          _conformPasswordTextEditingController.text.trim()) {
        if (EmailValidator.validate(_emailTextEditingController.text.trim()) ==
            true) {
          await _auth.createUserWithEmailAndPassword(
              email: _emailTextEditingController.text.trim(),
              password: _passwordTextEditingController.text.trim());
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(red_snackBar(e));
    }
    notifyListeners();
  }

  Future addUserDetails(
      User currentUser, String name, String image, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set(
      {
        'userId': currentUser.uid,
        'name': name,
        'image': image,
        'email': email,
      },
    );
    notifyListeners();
  }

  Future resetPassword(BuildContext context, String forgotEmail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(red_snackBar(e.toString()));
    }
  }

  notifyListeners();
}
