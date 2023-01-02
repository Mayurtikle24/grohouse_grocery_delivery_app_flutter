import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/HomeDrawer/drawerScreen.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [DrawerScreen(), HomePage()],
      ),
    );
  }
}
