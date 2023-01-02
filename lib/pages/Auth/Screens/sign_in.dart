import 'package:auth_buttons/auth_buttons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/main_page.dart';
import 'package:flutter_grocery_delivery_app/providers/auth_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import '../../../services/constants.dart';
import '../../../services/internet_service.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  var _emailTextEditingController = TextEditingController();
  var _passwordTextEditingController = TextEditingController();
  late AuthProvider _authProvider;
  bool isLogin = false;

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validation(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  bool emailVerification = false;

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    var networkStatus = Provider.of<NetworkStatus>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "GRO",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 49, 88),
                        ),
                      ),
                      Text(
                        "HOUSE",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 40, 24),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(right: 230, bottom: 10),
                  child: Text(
                    "LogIn",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 260),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                            controller: _emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a Valid Email'
                                    : null,
                            autofillHints: [AutofillHints.email],
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(Icons.email),
                              errorStyle: TextStyle(height: 0.1),
                              hintText: "Email ID",
                              labelStyle: TextStyle(fontFamily: "Circular"),
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 152, 149, 149)),
                            )),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(right: 230),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 7),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                              controller: _passwordTextEditingController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter password";
                                } else {
                                  //call function to check password
                                  bool result = validation(value);
                                  if (result) {
                                    // create account event
                                    return null;
                                  } else {
                                    return " Password should contain Capital, small letter & Number & Special";
                                  }
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: passwordVisibility,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passwordVisibility =
                                            !passwordVisibility;
                                      });
                                    },
                                    child: passwordVisibility
                                        ? Icon(Icons.visibility_off,
                                            color: Colors.grey)
                                        : Icon(Icons.visibility)),
                                hintText: "Password",
                                errorStyle: TextStyle(height: 1),
                                labelText: "Password",
                                labelStyle: TextStyle(fontFamily: "Circular"),
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 152, 149, 149)),
                              )),
                        ),
                      ),
                      SizedBox(height: 7)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 210,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ForgotPassword();
                      }));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.none,
                          color: Color.fromARGB(255, 2, 119, 214),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: networkStatus == NetworkStatus.Online
                      ? GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              _authProvider.signIn(
                                  context,
                                  _emailTextEditingController,
                                  _passwordTextEditingController);

                              if (_authProvider.isLogin == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    green_snackBar("LogIn Successfully"));
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return MainPage();
                                }));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  red_snackBar("Something Went Wrong"));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 3, 127, 228),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => ScaffoldMessenger.of(context)
                              .showSnackBar(red_snackBar(
                                  "Check Your Internet Connection")),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 3, 127, 228),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Login",
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
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 36,
                          color: Color.fromARGB(255, 163, 164, 165),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 129, 130, 132),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 40),
                        child: Divider(
                          height: 36,
                          color: Color.fromARGB(255, 163, 164, 165),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IgnorePointer(
                        ignoring: networkStatus == NetworkStatus.Online
                            ? false
                            : true,
                        child: GoogleAuthButton(
                          onPressed: () {
                            _authProvider.googleSignIn(context);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return MainPage();
                            }));
                          },
                          style: AuthButtonStyle(
                            iconType: AuthIconType.secondary,
                            elevation: 6,
                            iconSize: 27,
                            margin: EdgeInsets.only(left: 15),
                            borderColor: Colors.amber,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont't Have Account? ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
                      },
                      child: const Text(
                        "SignUp",
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
        ),
      ),
    );
  }
}
