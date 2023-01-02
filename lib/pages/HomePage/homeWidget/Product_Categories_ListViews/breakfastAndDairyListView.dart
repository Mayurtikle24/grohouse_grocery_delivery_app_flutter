import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/DetailPage/Grocery_detail_screen.dart';
import 'package:flutter_grocery_delivery_app/providers/productProvider.dart';
import 'package:provider/provider.dart';
import '../../../../Theme/themeProvider.dart';
import '../../../Search Screen/SearchPage.dart';
import '../grocery_cardUI.dart';

class BreakfastAndDairyListViewWidget extends StatefulWidget {
  const BreakfastAndDairyListViewWidget({Key? key}) : super(key: key);

  @override
  State<BreakfastAndDairyListViewWidget> createState() =>
      _BreakfastAndDairyListViewWidgetState();
}

class _BreakfastAndDairyListViewWidgetState
    extends State<BreakfastAndDairyListViewWidget> {
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
                "Breakfast and Dairy",
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
                        searchList: _productProvider.getBreakfastAndDairyList);
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
            children: _productProvider.getBreakfastAndDairyList.map((product) {
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
