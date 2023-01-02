import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_delivery_app/pages/Delivery_Details_Page/Widgets/address_TextEditing_Widget.dart';
import 'package:flutter_grocery_delivery_app/pages/Location/location_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../Theme/colors.dart';
import '../../Theme/themeProvider.dart';
import '../../providers/check_out_provider.dart';

class AddDeliveryDetailsPage extends StatefulWidget {
  @override
  State<AddDeliveryDetailsPage> createState() => _AddDeliveryDetailsPageState();
}

enum AddressType { Home, Work, Other }

class _AddDeliveryDetailsPageState extends State<AddDeliveryDetailsPage> {
  String initialCountry = 'IN';
  late CheckoutProvider checkoutProvider;

  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  late LocationData locationData;

  @override
  Widget build(BuildContext context) {
    checkoutProvider = Provider.of<CheckoutProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);
    var myType = AddressType.Home;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 3, 46, 82)
          : Colors.white,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? backroundColor : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Delivery Details",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressTextEditingWidget(
                  title: "First Name",
                  iconData: Icons.person,
                  controller: checkoutProvider.firstNameTextEditingController,
                  hintText: "First Name"),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "Last Name",
                  iconData: Icons.person,
                  controller: checkoutProvider.lastNameTextEditingController,
                  hintText: "Last Name"),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Phone",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 16),
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                    height: 50,
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 214, 228, 240)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {},
                        autoValidateMode: AutovalidateMode.disabled,
                        textFieldController:
                            checkoutProvider.phoneTextEditingController,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        cursorColor: Colors.black,
                        initialValue: number,
                        onSaved: (PhoneNumber number) {
                          checkoutProvider.phoneTextEditingController.text =
                              "+91" + number.phoneNumber!;
                        },
                        countries: ['IN'],
                        selectorTextStyle: TextStyle(color: Colors.black),
                        inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                                color: Colors.green.shade500, fontSize: 16)),
                      ),
                    )),
              ),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "Society",
                  iconData: Icons.location_city,
                  controller: checkoutProvider.societyTextEditingController,
                  hintText: "Society"),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "Street",
                  iconData: Icons.location_history_rounded,
                  controller: checkoutProvider.streetTextEditingController,
                  hintText: "Street"),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "LandMart",
                  iconData: Icons.location_on,
                  controller: checkoutProvider.landmarkTextEditingController,
                  hintText: "LandMark"),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "City",
                  iconData: Icons.location_city,
                  controller: checkoutProvider.cityTextEditingController,
                  hintText: "City"),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "Area",
                  iconData: Icons.home,
                  controller: checkoutProvider.areaTextEditingController,
                  hintText: "Area"),
              SizedBox(height: 7),
              AddressTextEditingWidget(
                  title: "Pincode",
                  iconData: Icons.pin_outlined,
                  controller: checkoutProvider.pincodeTextEditingController,
                  hintText: "Pincode"),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Set Location",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 16),
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: checkoutProvider.isLoading == false
                    ? GestureDetector(
                        onTap: () {
                          checkoutProvider.setLocation == null
                              ? Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                  return LocationScreen();
                                }))
                              : Container();
                        },
                        child: Container(
                          height: 50,
                          width: 340,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: themeProvider.isDarkMode
                                  ? Colors.yellow[200]
                                  : Color.fromARGB(255, 119, 168, 210)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Text(
                                checkoutProvider.setLocation == null
                                    ? "Set Location"
                                    : "Done!",
                                style: TextStyle(
                                    fontFamily: "Circluar",
                                    fontSize: 17,
                                    color: themeProvider.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              SizedBox(height: 7),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return AddDeliveryDetailsPage();
                  }));
                },
                child: Center(
                  child: GestureDetector(
                    onTap: (() {
                      checkoutProvider.validator(
                        context,
                        myType,
                      );
                    }),
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 55,
                      width: 340,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 3, 112, 201),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "Add Address",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Circular",
                            fontSize: 16),
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(height: 15),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Address Type",
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.deepOrangeAccent
                                  : Color.fromARGB(255, 18, 79, 132),
                              fontFamily: "Circluar",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      RadioListTile(
                        value: AddressType.Home,
                        groupValue: myType,
                        title: Text(
                          "Home",
                          style: TextStyle(
                              fontFamily: "Circluar",
                              color: themeProvider.isDarkMode
                                  ? Colors.pink
                                  : Colors.blue[900],
                              fontWeight: FontWeight.normal,
                              fontSize: 18),
                        ),
                        onChanged: (AddressType? value) {
                          setState(() {
                            myType = value!;
                          });
                        },
                        secondary: Container(
                          height: 35,
                          child: Image.asset("assets/icons/home.png"),
                        ),
                      ),
                      RadioListTile(
                        value: AddressType.Work,
                        title: Text(
                          "Work",
                          style: TextStyle(
                              fontFamily: "Circluar",
                              fontWeight: FontWeight.normal,
                              color: themeProvider.isDarkMode
                                  ? Colors.pink
                                  : Colors.blue[900],
                              fontSize: 18),
                        ),
                        groupValue: myType,
                        onChanged: (AddressType? value) {
                          setState(() {
                            myType = value!;
                          });
                        },
                        secondary: Container(
                          height: 35,
                          child: Image.asset("assets/icons/work.png"),
                        ),
                      ),
                      RadioListTile(
                        value: AddressType.Other,
                        groupValue: myType,
                        title: Text(
                          "Other",
                          style: TextStyle(
                              fontFamily: "Circluar",
                              fontWeight: FontWeight.normal,
                              color: themeProvider.isDarkMode
                                  ? Colors.pink
                                  : Colors.blue[900],
                              fontSize: 18),
                        ),
                        onChanged: (AddressType? value) {
                          setState(() {
                            myType = value!;
                          });
                        },
                        secondary: Container(
                          height: 35,
                          child: Image.asset(
                            "assets/icons/phone (2).png",
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
