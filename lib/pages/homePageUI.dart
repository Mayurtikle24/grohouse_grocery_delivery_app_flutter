import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/attaAndGrainsListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/breakfastAndDairyListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/chocolatesAndDessertsListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/freshFruitesListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/freshVegetablesListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/homeCareListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/instantFoodListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/oilsListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/personalCareListView.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/snacksAndBeveragesListView%20.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Product_Categories_ListViews/spicesListView.dart';
import 'HomePage/homeWidget/Product_Categories_ListViews/topProductsListView.dart';
import 'HomePage/homeWidget/grocery_card_ads.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const GroceryAdsCardWidget(),
            const SizedBox(height: 10),
            const TopProductListViewWidget(),
            const SizedBox(height: 10),
            const SnacksAndBeveragesListViewWidget(),
            const SizedBox(height: 10),
            const PersonalCareListViewWidget(),
            const SizedBox(height: 10),
            const HomeCareListViewWidget(),
            const SizedBox(height: 10),
            const SpicesListViewWidget(),
            const SizedBox(height: 10),
            const BreakfastAndDairyListViewWidget(),
            const SizedBox(height: 10),
            const AttaAndGrainsListViewWidget(),
            const SizedBox(height: 10),
            const ChocolatesAndDessetsListViewWidget(),
            const SizedBox(height: 10),
            const FreshFruitesListViewWidget(),
            const SizedBox(height: 10),
            const FreshVegetableListViewWidget(),
            const SizedBox(height: 10),
            const InstantFoodListViewWidget(),
            const SizedBox(height: 10),
            const OilsListViewWidget(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
