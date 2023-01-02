import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/model/product_model.dart';
import 'package:flutter_grocery_delivery_app/pages/DetailPage/Grocery_detail_screen.dart';
import 'package:flutter_grocery_delivery_app/services/noInternetWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/internet_service.dart';
import '../wishList Page/wishListcart_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.searchList,
  }) : super(key: key);

  final List<ProductModel> searchList;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchProduct = widget.searchList.where((element) {
      return element.title.toLowerCase().contains(query);
    }).toList();
    return searchProduct;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> serchItem = searchItem(query);
    var networkStatus = Provider.of<NetworkStatus>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 3, 46, 82)
          : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: (() => Navigator.pop(context)),
                        child: Icon(
                          Icons.arrow_back,
                          color: textColor,
                          size: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Material(
                        elevation: themeProvider.isDarkMode ? 0 : 0,
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Color.fromARGB(255, 123, 120, 120),
                                  width: 0.7,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              autocorrect: true,
                              autofocus: false,
                              cursorColor: themeProvider.isDarkMode
                                  ? Colors.amber
                                  : Colors.green[600],
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  query = value;
                                });
                              },
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Circular"),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.search,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45),
                                  border: InputBorder.none,
                                  hintText: "Search for an item in GroHouse"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                networkStatus == NetworkStatus.Offline
                    ? NoInternetWidget()
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: serchItem.isEmpty
                            ? Center(
                                child: Lottie.asset(
                                    "assets/lottie/emptySearch.json",
                                    height: 500,
                                    width: MediaQuery.of(context).size.width),
                              )
                            : Column(
                                children: serchItem.map((product) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return ProductDetailScreen(
                                            id: product.id,
                                            img: product.img,
                                            title: product.title,
                                            price: product.price,
                                            quantity: product.quantity,
                                            unit: product.unit,
                                            desc: "");
                                      }));
                                    },
                                    child: WishListCartWidget(
                                      id: product.id,
                                      img: product.img,
                                      wishList: false,
                                      price: product.price,
                                      quantity: product.quantity,
                                      unit: product.unit,
                                      title: product.title,
                                      onDelete: () {},
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
