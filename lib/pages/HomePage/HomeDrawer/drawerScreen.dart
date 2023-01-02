import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/HomeDrawer/Widgets/drawer_footer.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/HomeDrawer/Widgets/drawer_menu_items.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/HomeDrawer/Widgets/drawer_heading.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 209, 194, 234),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              DrawerHeaderWidget(),
              DrawerMenuItemWidget(),
              DrawerFooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}
