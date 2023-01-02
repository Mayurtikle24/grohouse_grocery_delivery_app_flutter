import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/Category_card_ui.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Theme/themeProvider.dart';
import '../../../../providers/productProvider.dart';

class CategoriesListViewWidget extends StatefulWidget {
  const CategoriesListViewWidget({Key? key}) : super(key: key);

  @override
  State<CategoriesListViewWidget> createState() =>
      _CategoriesListViewWidgetState();
}

class _CategoriesListViewWidgetState extends State<CategoriesListViewWidget> {
  late ProductProvider _productProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(255, 16, 81, 134);
    return isLoading
        ? getCategoryShimmerLoading()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontFamily: "Lora",
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 36,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: _productProvider.getCategoryList.map((category) {
                      return CategoryCardUI(category: category);
                    }).toList(),
                  ),
                ),
              ),
            
            ],
          );
  }

  Shimmer getCategoryShimmerLoading() {
    return Shimmer.fromColors(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _productProvider.getCategoryList.map((category) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                height: 120,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 2,
                      left: 2,
                      child: Container(
                        height: 15,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 54, 6, 113),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      top: 25,
                      child: Container(
                        height: 70,
                        width: 90,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                    Positioned(
                        top: 95,
                        left: 12,
                        child: Container(
                            height: 5, width: 10, color: Colors.white))
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.white.withOpacity(0.6),
        period: Duration(seconds: 1));
  }
}
