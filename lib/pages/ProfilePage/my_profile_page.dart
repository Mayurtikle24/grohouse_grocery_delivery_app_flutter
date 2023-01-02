import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/colors.dart';
import 'package:flutter_grocery_delivery_app/pages/Auth/Screens/sign_in.dart';
import 'package:flutter_grocery_delivery_app/pages/Delivery_Details_Page/delivery_detail_Page.dart';
import 'package:flutter_grocery_delivery_app/pages/ProfilePage/Widget/profile_menu_widget.dart';
import 'package:flutter_grocery_delivery_app/pages/ReviewCart/review_cart.dart';
import 'package:provider/provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/internet_service.dart';
import '../../services/noInternetWidget.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    final user = FirebaseAuth.instance.currentUser;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 46, 82),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Color.fromARGB(255, 209, 194, 234),
        centerTitle: true,
        elevation: 0,
        title: Text(
          " Profile",
          style: TextStyle(
              color: textColor,
              fontSize: 25,
              fontWeight: FontWeight.normal,
              fontFamily: "Circular"),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.left_chevron,
              size: 27,
              color: textColor,
            ),
          ),
        ),
      ),
      body: networkStatus == NetworkStatus.Offline
          ? NoInternetWidget()
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: themeProvider.isDarkMode
                  ? Color.fromARGB(255, 3, 46, 82)
                  : Color.fromARGB(255, 209, 194, 234),
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    margin: EdgeInsets.only(
                        top: 110, left: 10, right: 10, bottom: 20),
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: themeProvider.isDarkMode
                            ? darkProductCard
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 140,
                          top: 20,
                          child: user?.displayName != null
                              ? Text(
                                  "${user?.displayName}",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lora"),
                                )
                              : Container(),
                        ),
                        Positioned(
                            left: 140,
                            top: 45,
                            child: Text(
                              "${user?.email}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Lora",
                                  color: textColor),
                            )),
                        Positioned(
                            top: 90,
                            child: Column(
                              children: [
                                Container(
                                  height: 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  color: Color.fromARGB(255, 198, 196, 196),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return Review_Cart_Page();
                                    }));
                                  },
                                  child: ProfileMenuItems(
                                      icon: Icons.badge_sharp,
                                      title: "My Orders"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DeliveryDetailPage();
                                    }));
                                  },
                                  child: ProfileMenuItems(
                                      icon: Icons.location_city,
                                      title: "My Delivery Details"),
                                ),
                                ProfileMenuItems(
                                    icon: Icons.pages,
                                    title: "Terms & Conditions"),
                                ProfileMenuItems(
                                    icon: Icons.security,
                                    title: "Privacy Policy"),
                                ProfileMenuItems(
                                    icon: Icons.share,
                                    title: "Refer A Friends"),
                                GestureDetector(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut().then(
                                        (value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn())));
                                  },
                                  child: ProfileMenuItems(
                                      icon: Icons.logout, title: "Log Out"),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )),
                  Positioned(
                    top: 60,
                    left: 35,
                    child: user?.photoURL == null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.pink[300],
                                borderRadius: BorderRadius.circular(40)),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.pink[300],
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                    image: NetworkImage("${user?.photoURL}"),
                                    fit: BoxFit.cover)),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
