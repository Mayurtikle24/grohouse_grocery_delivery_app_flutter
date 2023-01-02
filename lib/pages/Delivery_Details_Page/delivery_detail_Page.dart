import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/model/delivery_Detail_model.dart';
import 'package:flutter_grocery_delivery_app/pages/Delivery_Details_Page/add_delivery_detailsPage.dart';
import 'package:flutter_grocery_delivery_app/pages/Delivery_Details_Page/Widgets/address_widget.dart';
import 'package:flutter_grocery_delivery_app/pages/Payment_Summary_Page/payment_summery.dart';
import 'package:flutter_grocery_delivery_app/providers/check_out_provider.dart';
import 'package:provider/provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/internet_service.dart';
import '../../services/noInternetWidget.dart';

class DeliveryDetailPage extends StatefulWidget {
  @override
  State<DeliveryDetailPage> createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  DeliveryDetailModel? value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    var networkStatus = Provider.of<NetworkStatus>(context);
    checkoutProvider.getDeliveryDetailsData();
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 3, 46, 82)
          : Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Delivery Details",
          style: TextStyle(fontFamily: "Circular", color: textColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.arrow_left,
              color: textColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: networkStatus == NetworkStatus.Offline
          ? NoInternetWidget()
          : GestureDetector(
              onTap: () {
                checkoutProvider.deliveryDetailsList.isEmpty
                    ? Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                        return AddDeliveryDetailsPage();
                      }))
                    : Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                        return PaymentSummeryPage(
                          deliveryAddressList: value,
                        );
                      }));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 55,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 112, 201),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    checkoutProvider.deliveryDetailsList.isEmpty
                        ? "Add New Address"
                        : "Payment Summery",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Circular",
                        fontSize: 16),
                  )),
                ),
              ),
            ),
      floatingActionButton: networkStatus == NetworkStatus.Offline
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(top: 740),
              child: new FloatingActionButton(
                  elevation: 10,
                  mini: true,
                  child: new Icon(Icons.add),
                  backgroundColor: themeProvider.isDarkMode
                      ? Colors.amber
                      : new Color(0xFFE57373),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddDeliveryDetailsPage();
                    }));
                  }),
            ),
      body: networkStatus == NetworkStatus.Offline
          ? NoInternetWidget()
          : Padding(
              padding: const EdgeInsets.only(top: 10, left: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              "assets/images/location.png",
                            ),
                          )),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Deliver To",
                          style: TextStyle(
                              color: textColor,
                              fontFamily: "Circular",
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Divider(
                      height: 35,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black),
                  Column(
                      children:
                          checkoutProvider.getDeliveryDetailsList.map((e) {
                    setState(() {
                      value = e;
                    });
                    return AddressDetailsWidget(
                        name: "${e.firstName} ${e.lastName}",
                        address:
                            "${e.street},${e.society},${e.landMark},${e.city},${e.pincode}",
                        number: "${e.phone}",
                        addressType: e.addressType == "AddressType.Home"
                            ? "Home"
                            : e.addressType == "AddressType.Work"
                                ? "Work"
                                : "Other");
                  }).toList())
                ],
              ),
            ),
    );
  }
}
