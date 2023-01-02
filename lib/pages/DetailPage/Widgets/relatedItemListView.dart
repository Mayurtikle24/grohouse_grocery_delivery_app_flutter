import 'package:flutter/material.dart';

class RealatedItemListView extends StatelessWidget {
  const RealatedItemListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // itemCount: GroceryListItem.groceryListItem.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              // child: RelatedItemCardWidget(
              //     grocery: GroceryListItem.groceryListItem[index]),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                // return GroceryDetailScreen(
                //     grocery: GroceryListItem.groceryListItem[index]);
                // }));
              },
            );
          }),
    );
  }
}
