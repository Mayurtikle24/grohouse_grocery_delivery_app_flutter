class ReviewCartModel {
  String CartId;
  String CartTitle;
  String CartImg;
  int CartPrice;
  var CartUnit;
  int CartQuantity;

  ReviewCartModel({
    required this.CartId,
    required this.CartTitle,
    required this.CartImg,
    required this.CartPrice,
    required this.CartUnit,
    required this.CartQuantity,
  });
}
