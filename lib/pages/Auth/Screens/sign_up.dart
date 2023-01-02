import 'package:auth_buttons/auth_buttons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/main_page.dart';
import 'package:flutter_grocery_delivery_app/services/constants.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/internet_service.dart';
import 'sign_in.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkboxValue = false;
  bool passwordVisibility = true;
  bool conformPasswordVisibility = true;
  var _emailTextEditingController = TextEditingController();
  var _passwordTextEditingController = TextEditingController();
  var _conformPasswordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validation(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _conformPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    var networkStatus = Provider.of<NetworkStatus>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return SignIn();
                })),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 209, 228, 243),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Color.fromARGB(255, 7, 104, 184),
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(right: 225),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                            controller: _emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a Valid Email'
                                    : null,
                            autofillHints: [AutofillHints.email],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(Icons.email),
                              errorStyle: TextStyle(height: 0.1),
                              hintText: "Email ID",
                              labelText: "Email",
                              labelStyle: TextStyle(fontFamily: "Circular"),
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 152, 149, 149)),
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 10),
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
                                      passwordVisibility = !passwordVisibility;
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
                    SizedBox(height: 15),
                    Text(
                      "Conform Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(height: 10),
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
                            controller: _conformPasswordTextEditingController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              } else if (_passwordTextEditingController.text
                                      .trim() !=
                                  _conformPasswordTextEditingController.text
                                      .trim()) {
                                return "Enter Correct Confirm password";
                              } else {
                                bool result = validation(value);
                                if (result) {
                                  return null;
                                } else {
                                  return " Password should contain Capital, small letter & Number & Special";
                                }
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: conformPasswordVisibility,
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
                                      conformPasswordVisibility =
                                          !conformPasswordVisibility;
                                    });
                                  },
                                  child: conformPasswordVisibility
                                      ? Icon(Icons.visibility_off,
                                          color: Colors.grey)
                                      : Icon(Icons.visibility)),
                              hintText: "Conform Password",
                              errorStyle: TextStyle(height: 1),
                              labelText: "Conform Password",
                              labelStyle: TextStyle(fontFamily: "Circular"),
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 152, 149, 149)),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Use 8 or more characters with a mix of letters.\n numbers,and symbols.",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "CircularStd",
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(136, 85, 82, 82),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    activeColor: Color.fromARGB(255, 7, 103, 181),
                    value: this.checkboxValue,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      setState(() {
                        this.checkboxValue = value!;
                      });
                    },
                    checkColor: Colors.white,
                    splashRadius: 2,
                  ),
                  Text("I agree to the ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "CircularStd",
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(137, 0, 0, 0),
                      )),
                  Text(
                    "Terms ",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      fontFamily: "CircularStd",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text("and ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "CircularStd",
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(137, 0, 0, 0),
                      )),
                  Text("Privacy Policy",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        fontFamily: "CircularStd",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
              SizedBox(height: 20),
              networkStatus == NetworkStatus.Online
                  ? GestureDetector(
                      onTap: () {
                        if (checkboxValue == true &&
                            _formKey.currentState!.validate()) {
                          _authProvider.signUp(
                              context,
                              _emailTextEditingController,
                              _passwordTextEditingController,
                              _conformPasswordTextEditingController);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return SignIn();
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              red_snackBar("Something Went Wrong"));
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              color: checkboxValue
                                  ? Color.fromARGB(255, 4, 98, 176)
                                  : Color.fromARGB(255, 178, 178, 178),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: checkboxValue
                                ? Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "SignUp",
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
                      onTap: () {
                        if (networkStatus == NetworkStatus.Offline) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              red_snackBar("Check your Internet Connection"));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 4, 98, 176),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 40, right: 10),
                      child: Divider(
                        height: 36,
                        color: Color.fromARGB(255, 11, 11, 11),
                      ),
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 129, 130, 132),
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 40),
                      child: Divider(
                        height: 36,
                        color: Color.fromARGB(255, 12, 12, 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IgnorePointer(
                    ignoring:
                        networkStatus == NetworkStatus.Online ? false : true,
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
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account? ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    }),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignIn();
                      })),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 2, 119, 214)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
