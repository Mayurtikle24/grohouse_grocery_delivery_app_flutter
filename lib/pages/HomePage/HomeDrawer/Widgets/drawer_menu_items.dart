import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/ProfilePage/my_profile_page.dart';
import 'package:flutter_grocery_delivery_app/pages/ReviewCart/review_cart.dart';
import 'package:flutter_grocery_delivery_app/pages/faqPage.dart';
import 'package:flutter_grocery_delivery_app/pages/main_page.dart';

import '../../../wishList Page/wishList_page.dart';
import 'drawerItem.dart';

class DrawerMenuItemWidget extends StatelessWidget {
  const DrawerMenuItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyProfilePage();
              }));
            },
            child: DrawerItems(icon: "assets/icons/man.png", title: "Profile")),
        const SizedBox(height: 20),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
            child: DrawerItems(icon: "assets/icons/home.png", title: "Home")),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Review_Cart_Page();
            }));
          },
          child: DrawerItems(
              icon: "assets/icons/rating.png", title: "Review Cart"),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FavouritePage();
            }));
          },
          child: DrawerItems(icon: "assets/icons/heart.png", title: "Wishlist"),
        ),
        const SizedBox(height: 20),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FaqPage();
              }));
            },
            child: DrawerItems(icon: "assets/icons/faq.png", title: "FAQs")),
        const SizedBox(height: 90),
        const Text(
          "Contact Support :",
          style: TextStyle(
              fontSize: 15, fontFamily: "Lora", fontWeight: FontWeight.bold),
        ),
        const Text(
          "Call us: +8983682842",
          style: TextStyle(fontSize: 12, fontFamily: "Lora"),
        ),
        const Text(
          "Mail us: grohouse@email.com",
          style: const TextStyle(fontSize: 12, fontFamily: "Lora"),
        )
      ],
    );
  }
}
