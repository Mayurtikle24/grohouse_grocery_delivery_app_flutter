import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/services/constants.dart';
import 'package:provider/provider.dart';
import '../../../../services/internet_service.dart';
import '../../../Auth/Screens/sign_in.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          networkStatus == NetworkStatus.Online
              ? Visibility(
                  visible: user?.photoURL != null,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 160, 160),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage("${user?.photoURL}"),
                            fit: BoxFit.cover)),
                  ),
                )
              : Container(),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              networkStatus == NetworkStatus.Online
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "${user?.displayName ?? ""}",
                        style: TextStyle(
                            fontFamily: "Circular",
                            fontSize: 18,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ))
                  : Container(),
              networkStatus == NetworkStatus.Online
                  ? Visibility(
                      visible: user != null,
                      child: Text(
                        "${user?.email ?? ""}",
                        style: TextStyle(
                            fontFamily: "Circular",
                            fontSize: 16,
                            color: Color.fromARGB(255, 108, 2, 141),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ))
                  : Container(),
              SizedBox(height: 5),
              networkStatus == NetworkStatus.Online
                  ? GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn())));
                      },
                      child: Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: const Text(
                              "LogOut",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            red_snackBar("Check Your Internet Connection"));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return SignIn();
                        }));
                      },
                      child: Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: const Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
            ],
          )
        ],
      ),
    );
  }
}
