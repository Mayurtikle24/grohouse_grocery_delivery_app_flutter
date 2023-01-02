import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Theme/themeProvider.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Column(
          children: [
            Lottie.asset("assets/lottie/nointernet.json",
                height: 300, width: 340),
            Text(
              textAlign: TextAlign.center,
              "Couldn't connect to Internet \n Please check your Network Settings.",
              style: TextStyle(
                  fontFamily: "Circular",
                  fontSize: 18,
                  color:
                      themeProvider.isDarkMode ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
