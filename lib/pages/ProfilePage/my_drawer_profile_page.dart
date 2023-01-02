import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/ProfilePage/Widget/profile_menu_widget.dart';

class MyDrawerProfilePage extends StatelessWidget {
  const MyDrawerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (() => Navigator.pop(context)),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 160, 160),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("assets/images/profile.png"),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Mayur Tikle",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Lora"),
                        ),
                        Text(
                          "mayurtikle24@gmail.com",
                          style: TextStyle(fontSize: 14, fontFamily: "Lora"),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 20),
                  child: Container(
                    height: 2,
                    width: 400,
                    color: Color.fromARGB(31, 104, 103, 103),
                  ),
                ),
                SizedBox(height: 20),
                ProfileMenuItems(icon: Icons.shop_sharp, title: "My Orders"),
                SizedBox(height: 20),
                const ProfileMenuItems(
                    icon: Icons.location_on, title: "My Delivery Address"),
                SizedBox(height: 20),
                ProfileMenuItems(
                    icon: Icons.offline_share, title: "Refer A Friends"),
                SizedBox(height: 20),
                ProfileMenuItems(
                    icon: Icons.privacy_tip, title: "Privacy Policy"),
                SizedBox(height: 20),
                ProfileMenuItems(
                    icon: Icons.pages_sharp, title: "Terms & Conditions"),
                SizedBox(height: 20),
                ProfileMenuItems(icon: Icons.settings, title: "Settings"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
