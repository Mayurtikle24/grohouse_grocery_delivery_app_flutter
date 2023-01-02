import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/Theme/themeProvider.dart';
import 'package:flutter_grocery_delivery_app/pages/ReviewCart/review_cart.dart';
import 'package:flutter_grocery_delivery_app/pages/homePageUI.dart';
import 'package:flutter_grocery_delivery_app/services/internet_service.dart';
import 'package:flutter_grocery_delivery_app/services/noInternetWidget.dart';
import 'package:provider/provider.dart';
import '../../Theme/widgets/changeThemeButton.dart';
import '../../providers/productProvider.dart';
import '../Search Screen/SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  bool isDrawerOpened = false;

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(scalefactor)
        ..rotateY(isDrawerOpened ? -0.5 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Scaffold(
          backgroundColor: themeProvider.isDarkMode
              ? Color.fromARGB(255, 3, 46, 82)
              : Colors.white,
          extendBody: false,
          appBar: AppBar(
            centerTitle: true,
            leading: isDrawerOpened
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        xoffset = 0;
                        yoffset = 0;
                        scalefactor = 1;
                        isDrawerOpened = false;
                      });
                    },
                    icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        xoffset = 260;
                        yoffset = 190;
                        scalefactor = 0.6;
                        isDrawerOpened = true;
                      });
                    },
                    icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        CupertinoIcons.bars,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("GRO",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 40, 24),
                        fontSize: themeProvider.isDarkMode ? 22 : 19,
                        fontFamily: "Circular",
                        fontWeight: FontWeight.normal)),
                Text(
                  "HOUSE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lora",
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage(
                      searchList: _productProvider.getAllProductSearch,
                    );
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      CupertinoIcons.search,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Review_Cart_Page();
                    }));
                  },
                  child: Image.asset(
                    "assets/icons/basket.png",
                    height: 5,
                    width: 30,
                  ),
                ),
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return ChangeThemeButtonWidget();
              }),
            ],
          ),
          body: networkStatus == NetworkStatus.Online
              ? HomePageUI()
              : NoInternetWidget()),
    );
  }
}
