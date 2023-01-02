import 'package:flutter/material.dart';

class ListTitleBar extends StatelessWidget {
  String title;
  ListTitleBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: "Circular",
                fontWeight: FontWeight.normal),
          ),
          TextButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return SearchPage();
              // }));
            },
            child: Text(
              "Explore All",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Lora",
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
