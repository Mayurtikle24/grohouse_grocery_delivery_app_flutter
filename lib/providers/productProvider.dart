import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_grocery_delivery_app/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> topProductList = [];
  List<ProductModel> freshVegetablesList = [];
  List<ProductModel> BreakfastAndDairyList = [];
  List<ProductModel> SnacksAndBeveragesList = [];
  List<ProductModel> attaFloursandGrainsList = [];
  List<ProductModel> chocolatesDessertsList = [];
  List<ProductModel> freshFruitsList = [];
  List<ProductModel> homeCareList = [];
  List<ProductModel> instantFoodList = [];
  List<ProductModel> oilsList = [];
  List<ProductModel> personalCareList = [];
  List<ProductModel> spicesList = [];
  List<CategoriesModel> categoriesList = [];

  late ProductModel productModel;
  late CategoriesModel categories;
  List<ProductModel> search = [];
  var prouctUnit;
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      id: element.get("productId"),
      title: element.get("productTitle"),
      img: element.get("productImage"),
      price: element.get("productPrice"),
      unit: element.get("unit"),
      quantity: element.get("productQuantity"),
    );
    search.add(productModel);
  }

  //Feaching Category Data From FirebaseFirestore.

  fetchCategoryData() async {
    List<CategoriesModel> newList = [];
    QuerySnapshot category =
        await FirebaseFirestore.instance.collection("Categories").get();

    category.docs.forEach(
      (category) {
        categories = CategoriesModel(
            title: category.get("categoryTitle"),
            img: category.get("categoryImage"),
            discount: category.get("categoryDiscount"));
        newList.add(categories);
      },
    );
    categoriesList = newList;
    notifyListeners();
  }

  //Feaching Top Product Data From FirebaseFirestore.

  fetchTopProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot topProducts =
        await FirebaseFirestore.instance.collection("TopProducts").get();

    topProducts.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    topProductList = newList;
    notifyListeners();
  }

  //Feaching Fresh Vegetables Data From FirebaseFirestore.

  fetchFreshVegetables() async {
    List<ProductModel> newList = [];
    QuerySnapshot freshVegetables =
        await FirebaseFirestore.instance.collection("Fresh Vegetables").get();

    freshVegetables.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    freshVegetablesList = newList;
    notifyListeners();
  }

  //Feaching BreakfastAndDairy Data From FirebaseFirestore.

  fetchBreakfastAndDairyData() async {
    List<ProductModel> newList = [];
    QuerySnapshot breakfastAndDairy = await FirebaseFirestore.instance
        .collection("Breakfast and Dairy")
        .get();

    breakfastAndDairy.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    BreakfastAndDairyList = newList;
    notifyListeners();
  }

  //Feaching Snacks And Beverages Data From FirebaseFirestore.

  fetchSnacksAndBeveragesData() async {
    List<ProductModel> newList = [];
    QuerySnapshot snackesAndbeverages = await FirebaseFirestore.instance
        .collection("Snacks and Beverages")
        .get();

    snackesAndbeverages.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    SnacksAndBeveragesList = newList;
    notifyListeners();
  }

  //Feaching Atta Flours and Grains Data From FirebaseFirestore.

  fetchAttaFloursandGrainsData() async {
    List<ProductModel> newList = [];
    QuerySnapshot attaAndGrains = await FirebaseFirestore.instance
        .collection("Atta Flours and Grains")
        .get();

    attaAndGrains.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    attaFloursandGrainsList = newList;
    notifyListeners();
  }

  //Feaching Chocolates & Desserts Data From FirebaseFirestore.

  fetchChocolatesDessertsData() async {
    List<ProductModel> newList = [];
    QuerySnapshot chocolatesDesserts = await FirebaseFirestore.instance
        .collection("Chocolates Desserts")
        .get();

    chocolatesDesserts.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    chocolatesDessertsList = newList;
    notifyListeners();
  }

  //Feaching Fresh Fruites Data From FirebaseFirestore.

  fetchFreshFruitsData() async {
    List<ProductModel> newList = [];
    QuerySnapshot freshFruits =
        await FirebaseFirestore.instance.collection("Fresh Fruits").get();

    freshFruits.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    freshFruitsList = newList;
    notifyListeners();
  }

  //Feaching Home Care Data From FirebaseFirestore.

  fetchHomeCareData() async {
    List<ProductModel> newList = [];
    QuerySnapshot homeCare =
        await FirebaseFirestore.instance.collection("Home Care").get();

    homeCare.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    homeCareList = newList;
    notifyListeners();
  }

  //Feaching Instant Food Data From FirebaseFirestore.

  fetchInstantFoodData() async {
    List<ProductModel> newList = [];
    QuerySnapshot instantFood =
        await FirebaseFirestore.instance.collection("Instant Foods").get();

    instantFood.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    instantFoodList = newList;
    notifyListeners();
  }

  //Feaching Oils Data From FirebaseFirestore.

  fetchOilsData() async {
    List<ProductModel> newList = [];
    QuerySnapshot oils =
        await FirebaseFirestore.instance.collection("Oils").get();

    oils.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    oilsList = newList;
    notifyListeners();
  }

  //Feaching Personal Care Data From FirebaseFirestore.

  fetchPersonalCareData() async {
    List<ProductModel> newList = [];
    QuerySnapshot personalCare =
        await FirebaseFirestore.instance.collection("Personal Care").get();

    personalCare.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    personalCareList = newList;
    notifyListeners();
  }

  //Feaching Spcies Data From FirebaseFirestore.

  fetchSpicesData() async {
    List<ProductModel> newList = [];
    QuerySnapshot spices =
        await FirebaseFirestore.instance.collection("Spices").get();

    spices.docs.forEach(
      (product) {
        productModels(product);
        newList.add(productModel);
      },
    );
    spicesList = newList;
    notifyListeners();
  }

  // Adding Getter to Categories List for Getting Product Data.

  List<ProductModel> get getTopProductsList {
    return topProductList;
  }

  List<CategoriesModel> get getCategoryList {
    return categoriesList;
  }

  List<ProductModel> get getFreshVegetableList {
    return freshVegetablesList;
  }

  List<ProductModel> get getBreakfastAndDairyList {
    return BreakfastAndDairyList;
  }

  List<ProductModel> get getSnacksAndBeveragesList {
    return SnacksAndBeveragesList;
  }

  List<ProductModel> get getAttaAndGrainsList {
    return attaFloursandGrainsList;
  }

  List<ProductModel> get getChocolatesDessertsList {
    return chocolatesDessertsList;
  }

  List<ProductModel> get getFreshFruitsList {
    return freshFruitsList;
  }

  List<ProductModel> get getHomeCareList {
    return homeCareList;
  }

  List<ProductModel> get getInstantFoodList {
    return instantFoodList;
  }

  List<ProductModel> get getOilsList {
    return oilsList;
  }

  List<ProductModel> get getPersonalCareList {
    return personalCareList;
  }

  List<ProductModel> get getSpicesList {
    return spicesList;
  }

  //Getting All Products from FirebaseFireStore.

  List<ProductModel> get getAllProductSearch {
    return search;
  }
}
