import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../Theme/themeProvider.dart';
import '../../providers/review_cart_Provider.dart';
import '../HomePage/homeWidget/product_counter_widget.dart';

class WishListCartWidget extends StatefulWidget {
  final String id;
  final String img;
  final bool wishList;
  final int price;
  final int quantity;
  var unit;
  final String title;
  final Function onDelete;

  WishListCartWidget({
    Key? key,
    required this.id,
    required this.img,
    required this.wishList,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.title,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<WishListCartWidget> createState() => _WishListCartWidgetState();
}

class _WishListCartWidgetState extends State<WishListCartWidget> {
  int quantity = 0;
  getCount() {
    setState(() {
      quantity = widget.quantity;
    });
  }

  bool isLoading = true;

  late ReviewCartProvider _reviewCartProvider;
  @override
  Widget build(BuildContext context) {
    _reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    getCount();
    _reviewCartProvider.getReviewCartData();
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      height: 102,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: themeProvider.isDarkMode ? darkProductCard : Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 4,
            child: Hero(
              tag: "productImage",
              child: Container(
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: "${widget.img}",
                  width: 90,
                  placeholder: (context, url) => getShimmerEffetct(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
            left: 90,
            child: Container(
              height: 110,
              width: 210,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${widget.title}",
                              style: TextStyle(
                                  fontFamily: "Circular",
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Color.fromARGB(255, 39, 38, 38),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "\u20B9",
                              style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.amber
                                      : Colors.black54,
                                  fontSize: 14),
                            ),
                            Text(
                              "${widget.price}",
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 105,
            child: Container(
              height: 1.4,
              width: 245,
              decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? darkProductCard
                      : Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
              top: 10,
              left: 265,
              child: GestureDetector(
                onTap: () => widget.onDelete(),
                child: Container(
                  height: 20,
                  width: 30,
                  child: Icon(Icons.delete,
                      color: Color.fromARGB(255, 220, 54, 42), size: 25),
                ),
              )),
          Positioned(
            top: 50,
            left: 250,
            child: widget.wishList == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductCounterWidget(
                        ProductId: widget.id,
                        ProductTitle: widget.title,
                        Productimg: widget.img,
                        Productprice: widget.price,
                        Productunit: widget.unit,
                      )
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Shimmer getShimmerEffetct() {
    return Shimmer.fromColors(
        child: Material(
          elevation: 10,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white12,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 2,
                  left: 4,
                  child: Container(
                    height: 100,
                  ),
                ),
                Positioned(
                  left: 90,
                  child: Container(
                    height: 110,
                    width: 210,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              SizedBox(height: 3),
                              Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 95,
                  child: Container(
                    height: 1.4,
                    width: 235,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 230,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 10,
                          child: Container(
                            height: 32,
                            width: 80,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.white.withOpacity(0.6),
        period: Duration(seconds: 1));
  }
}
