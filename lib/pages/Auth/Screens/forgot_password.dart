import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/Auth/Screens/sign_in.dart';
import 'package:flutter_grocery_delivery_app/providers/auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../services/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _forgotemailTextEditingController = TextEditingController();

  @override
  void dispose() {
    _forgotemailTextEditingController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  bool validation() {
    final bool? isValid = formKey.currentState?.validate();

    if (isValid == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (() => Navigator.pop(context)),
                  child: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    height: 240,
                    width: 250,
                    child: Lottie.asset("assets/lottie/forgetpassword.json"),
                  ),
                ),
                SizedBox(height: 30),
                const Text(
                  "Forgot",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "CircularStd",
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Password?",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "CircularStd",
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  "Don't worry! it happens.Please enter the",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "CircularStd",
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(137, 0, 0, 0),
                  ),
                ),
                Text(
                  "address associated with your account.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "CircularStd",
                    color: Color.fromARGB(137, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextFormField(
                      controller: _forgotemailTextEditingController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a Valid Email'
                              : null,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          hintText: "Emain ID",
                          labelStyle: TextStyle(fontFamily: "Circular"),
                          hintStyle: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 152, 149, 149)),
                          prefixIcon: Icon(
                            CupertinoIcons.mail,
                            size: 21,
                          ))),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (validation()) {
                        _authProvider.resetPassword(context,
                            _forgotemailTextEditingController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(
                            green_snackBar("Reset Password sent to Email "));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return SignIn();
                        }));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(red_snackBar("Something Went Wrong"));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 3, 127, 228),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
