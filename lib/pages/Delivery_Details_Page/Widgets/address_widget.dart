import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Theme/themeProvider.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({
    Key? key,
    required this.name,
    required this.address,
    required this.number,
    required this.addressType,
  }) : super(key: key);

  final String name;
  final String address;
  final String number;
  final String addressType;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: "Circular",
                  fontSize: 18,
                  color: themeProvider.isDarkMode
                      ? Colors.amber[200]
                      : Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 127, 228),
                    borderRadius: BorderRadiusDirectional.circular(20)),
                child: Center(
                  child: Text(
                    addressType,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: "Circular"),
                  ),
                ),
              )
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.amber,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color:
                      themeProvider.isDarkMode ? Colors.white : Colors.black54,
                  fontFamily: "Circular",
                ),
              ),
              Text(
                number,
                style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? Colors.orange[300]
                        : Color.fromARGB(255, 36, 36, 36),
                    fontFamily: "Circular",
                    fontSize: 16),
              )
            ],
          ),
        ),
        Divider(
          height: 15,
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
        )
      ],
    );
  }
}
