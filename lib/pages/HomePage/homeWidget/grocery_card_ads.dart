import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GroceryAdsCardWidget extends StatefulWidget {
  const GroceryAdsCardWidget({Key? key}) : super(key: key);

  @override
  State<GroceryAdsCardWidget> createState() => _GroceryAdsCardWidgetState();
}

class _GroceryAdsCardWidgetState extends State<GroceryAdsCardWidget> {
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
    return isLoading
        ? getShimmerEffect()
        : Container(
            height: 230,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                initialPage: 0,
              ),
              items: [
                GroceryCard(
                    image:
                        "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,metadata=none,w=450/layout-engine/2022-07/HUL_RN_0.jpg"),
                GroceryCard(
                    image:
                        "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,metadata=none,w=540/layout-engine/2022-06/morning-banner.jpg"),
                GroceryCard(
                    image:
                        "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,metadata=none,w=450/layout-engine/2022-07/Besan-Poha.png"),
                GroceryCard(
                    image:
                        "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,metadata=none,w=450/layout-engine/2022-04/dry-fruits_zomato.jpg"),
                GroceryCard(
                    image:
                        "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=50,metadata=none,w=450/layout-engine/2022-07/raksha-bandhan_RN-1_0.jpg"),
              ],
            ));
  }

  Shimmer getShimmerEffect() {
    return Shimmer.fromColors(
        child: Container(
            height: 230,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                initialPage: 0,
              ),
              items: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                )
              ],
            )),
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.white.withOpacity(0.6),
        period: Duration(seconds: 1));
  }
}

class GroceryCard extends StatelessWidget {
  String image;
  GroceryCard({
    Key? key,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: "${image}",
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

