class ProductModel {
  String id;
  String title;
  String img;
  int price;
  int quantity;
  List<dynamic> unit;

  ProductModel({
    required this.id,
    required this.title,
    required this.img,
    required this.price,
    required this.unit,
    required this.quantity,
  });
}

class CategoriesModel {
  String title;
  String img;
  int discount;

  CategoriesModel({
    required this.title,
    required this.img,
    required this.discount,
  });
}
