import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/colors.dart';
import 'package:flutter_grocery_delivery_app/Theme/themeProvider.dart';
import 'package:flutter_grocery_delivery_app/model/product_model.dart';
import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/product_unit_widget.dart';
import 'package:flutter_grocery_delivery_app/providers/productProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_grocery_delivery_app/pages/HomePage/homeWidget/product_counter_widget.dart';

class GroceryCardUI extends StatefulWidget {
  final String id;
  final String img;
  final String title;
  final int quntity;
  final int price;
  final ProductModel product_unit;
  

  GroceryCardUI({
    Key? key,
    required this.id,
    required this.img,
    required this.title,
    required this.quntity,
    required this.price,
    required this.product_unit,
  }) : super(key: key);

  @override
  State<GroceryCardUI> createState() => _GroceryCardUIState();
}

class _GroceryCardUIState extends State<GroceryCardUI> {
  bool isLoading = true;
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  var unitData;
  var firstIndex;
  var productUnit;
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    productUnit = firstIndex;
    widget.product_unit.unit.firstWhere((element) {
      setState(() {
        firstIndex = element;
      });
      return true;
    });

    return isLoading
        ? getShimmerEffect()
        : Container(
            margin: EdgeInsets.only(right: 10),
            width: 170,
            child: Card(
              color: themeProvider.isDarkMode ? darkProductCard : Colors.white,
              child: Container(
                height: 220,
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeProvider.isDarkMode
                        ? darkProductCard
                        : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 15,
                        left: 18,
                        child: Container(
                          height: 80,
                          width: 80,
                          child: Center(
                            child: Hero(
                              tag: "productImage",
                              child: CachedNetworkImage(
                                key: UniqueKey(),
                                imageUrl: "${widget.img}",
                                placeholder: (context, url) =>
                                    getShimmerEffect(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 105,
                        child: Text(
                          "${widget.title}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Circular",
                              color: textColor,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      ProductCounterWidget(
                          ProductId: widget.id,
                          ProductTitle: widget.title,
                          Productimg: widget.img,
                          Productprice: widget.price,
                          Productunit:
                              unitData == null ? firstIndex : unitData),
                      Positioned(
                          top: 130,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  clipBehavior: Clip.antiAlias,
                                  isScrollControlled: true,
                                  elevation: 3,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        Container(
                                          height: 350,
                                          decoration: BoxDecoration(
                                              color: themeProvider.isDarkMode
                                                  ? darkProductCard
                                                  : Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 55,
                                                      width: 55,
                                                      child: Image.asset(
                                                        "assets/images/shopping-bag.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30,
                                                            bottom: 10),
                                                        height: 23,
                                                        width: 23,
                                                        child: Image.asset(
                                                          "assets/images/close.png",
                                                          color: textColor,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3, top: 10),
                                                  child: Text(
                                                    "Availble quantities",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor,
                                                        fontSize: 21,
                                                        fontFamily: "Circular"),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 8,
                                                        width: 8,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "${widget.title}",
                                                        style: TextStyle(
                                                            color: themeProvider
                                                                    .isDarkMode
                                                                ? Colors.amber
                                                                : Colors
                                                                    .black54,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: Text(
                                                    "Choose Variant",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor,
                                                        fontSize: 18,
                                                        fontFamily: "Circular"),
                                                  ),
                                                ),
                                                Column(
                                                  children: widget
                                                      .product_unit.unit
                                                      .map<Widget>((data) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () async {
                                                              productProvider
                                                                      .prouctUnit =
                                                                  data;
                                                              setState(() {
                                                                unitData = data;
                                                              });

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                              child: Text(
                                                                data,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: themeProvider.isDarkMode
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .black87,
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        "Circluar",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            )),
                                                      ],
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: ProductUnitWidget(
                                title:
                                    unitData == null ? firstIndex : unitData),
                          )),
                      Positioned(
                        top: 155,
                        left: 3,
                        child: Text(
                          "\u20B9" + " ${widget.price}/${firstIndex}",
                          style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                              fontFamily: "Lora"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Shimmer getShimmerEffect() {
    return Shimmer.fromColors(
        child: Container(
          margin: EdgeInsets.only(right: 10),
          width: 150,
          child: Card(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 18,
                      child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                        top: 115,
                        child: Container(
                            height: 5, width: 20, color: Colors.white)),
                    Positioned(
                        top: 140,
                        child: Container(
                            height: 5, width: 20, color: Colors.white)),
                    Positioned(
                        top: 165,
                        child: Container(
                            height: 5, width: 20, color: Colors.white)),
                    Positioned(
                      top: 160,
                      left: 90,
                      child: Material(
                        elevation: 5,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 23, 96, 155),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.white.withOpacity(0.6),
        period: Duration(seconds: 1));
  }
}
