import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_grocery_delivery_app/model/review_cart_model.dart';

import '../../../Theme/themeProvider.dart';

class OrderItem extends StatelessWidget {
  late bool isTrue;
  final ReviewCartModel reviewCartModel;
  OrderItem({
    Key? key,
    required this.reviewCartModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      leading: CachedNetworkImage(
        width: 60,
        imageUrl: "${reviewCartModel.CartImg}",
        placeholder: (context, url) => getShimmerEffect(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${reviewCartModel.CartTitle}",
            style: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.white : Colors.grey[600]),
          ),
          Text(
            "${reviewCartModel.CartQuantity}",
            style: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.white : Colors.grey[600]),
          ),
          Text(
            "\u20B9" + "${reviewCartModel.CartPrice}",
            style: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.amber : Colors.grey[600]),
          )
        ],
      ),
      subtitle: Text(
        "${reviewCartModel.CartUnit}",
        style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.grey[600]),
      ),
    );
  }

  getShimmerEffect() {
    return Shimmer.fromColors(
        child: ListTile(
          leading: Container(height: 60),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 20, width: 60, color: Colors.white),
              Container(height: 20, width: 40, color: Colors.white),
              Container(height: 20, width: 40, color: Colors.white),
            ],
          ),
          subtitle: Container(height: 20, width: 40, color: Colors.white),
        ),
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.white.withOpacity(0.6),
        period: Duration(seconds: 1));
  }
}
