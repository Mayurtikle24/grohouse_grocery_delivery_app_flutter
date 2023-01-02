import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/DetailPage/Grocery_detail_screen.dart';
import 'package:flutter_grocery_delivery_app/providers/productProvider.dart';
import 'package:provider/provider.dart';
import '../../../../Theme/themeProvider.dart';
import '../../../Search Screen/SearchPage.dart';
import '../grocery_cardUI.dart';

class ChocolatesAndDessetsListViewWidget extends StatefulWidget {
  const ChocolatesAndDessetsListViewWidget({Key? key}) : super(key: key);

  @override
  State<ChocolatesAndDessetsListViewWidget> createState() =>
      _ChocolatesAndDessetsListViewWidgetState();
}

class _ChocolatesAndDessetsListViewWidgetState
    extends State<ChocolatesAndDessetsListViewWidget> {
  late ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(255, 16, 81, 134);
    Color exploreColor =
        themeProvider.isDarkMode ? Colors.amber : Colors.lightBlue;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chocolates And Desserts",
                style: TextStyle(
                    fontFamily: "Lora",
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchPage(
                        searchList: _productProvider.getChocolatesDessertsList);
                  }));
                },
                child: Text(
                  "Explore All",
                  style: TextStyle(
                      fontFamily: "Lora",
                      color: exploreColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _productProvider.getChocolatesDessertsList.map((product) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProductDetailScreen(
                        id: product.id,
                        img: product.img,
                        title: product.title,
                        price: product.price,
                        quantity: product.quantity,
                        unit: product.unit,
                        desc: "",
                      );
                    }));
                  },
                  child: GroceryCardUI(
                      id: product.id,
                      img: product.img,
                      title: product.title,
                      quntity: product.quantity,
                      product_unit: product,
                      price: product.price));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
