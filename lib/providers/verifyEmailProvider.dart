import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailProvider with ChangeNotifier {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      canResendEmail = false;
      notifyListeners();

      await Future.delayed(Duration(seconds: 5));
      canResendEmail = true;
      notifyListeners();
    } catch (e) {}
  }

  Future checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    notifyListeners();

    if (!isEmailVerified) timer?.cancel();
  }
}
