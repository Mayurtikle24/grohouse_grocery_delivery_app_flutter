import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_grocery_delivery_app/Theme/MyTheme.dart';
import 'package:flutter_grocery_delivery_app/Theme/themeProvider.dart';
import 'package:flutter_grocery_delivery_app/pages/splash_screen.dart';
import 'package:flutter_grocery_delivery_app/providers/auth_provider.dart';
import 'package:flutter_grocery_delivery_app/providers/check_out_provider.dart';
import 'package:flutter_grocery_delivery_app/providers/location_provider.dart';
import 'package:flutter_grocery_delivery_app/providers/productProvider.dart';
import 'package:flutter_grocery_delivery_app/providers/review_cart_Provider.dart';
import 'package:flutter_grocery_delivery_app/providers/verifyEmailProvider.dart';
import 'package:flutter_grocery_delivery_app/providers/wishList_provider.dart';
import 'package:flutter_grocery_delivery_app/services/internet_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => ReviewCartProvider()),
      ChangeNotifierProvider(create: (_) => WishListProvider()),
      ChangeNotifierProvider(create: (_) => CheckoutProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => VerifyEmailProvider()),
      StreamProvider(
          create: (context) => NetworkService().controller.stream,
          initialData: NetworkStatus.Online)
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ProductProvider _productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    _productProvider.fetchTopProductData();
    _productProvider.fetchFreshVegetables();
    _productProvider.fetchBreakfastAndDairyData();
    _productProvider.fetchSnacksAndBeveragesData();
    _productProvider.fetchCategoryData();
    _productProvider.fetchFreshFruitsData();
    _productProvider.fetchAttaFloursandGrainsData();
    _productProvider.fetchChocolatesDessertsData();
    _productProvider.fetchFreshFruitsData();
    _productProvider.fetchHomeCareData();
    _productProvider.fetchInstantFoodData();
    _productProvider.fetchOilsData();
    _productProvider.fetchPersonalCareData();
    _productProvider.fetchSpicesData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GroHouse',
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: SplashScreen()
    );
  }
}
