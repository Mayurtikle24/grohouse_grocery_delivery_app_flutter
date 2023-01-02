import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_grocery_delivery_app/model/delivery_Detail_model.dart';
import 'package:flutter_grocery_delivery_app/pages/Payment_Summary_Page/Widget/order_Item.dart';
import 'package:flutter_grocery_delivery_app/pages/Payment_Summary_Page/successfulPayment.dart';
import 'package:flutter_grocery_delivery_app/providers/review_cart_Provider.dart';
import '../../Theme/themeProvider.dart';
import '../../services/internet_service.dart';
import '../../services/noInternetWidget.dart';
import '../Delivery_Details_Page/Widgets/address_widget.dart';

class PaymentSummeryPage extends StatefulWidget {
  final DeliveryDetailModel? deliveryAddressList;
  const PaymentSummeryPage({
    Key? key,
    this.deliveryAddressList,
  }) : super(key: key);

  @override
  State<PaymentSummeryPage> createState() => _PaymentSummeryPageState();
}

enum PaymentOptions { Cash, OnlinePayment }

class _PaymentSummeryPageState extends State<PaymentSummeryPage> {
  var paymentType = PaymentOptions.OnlinePayment;
  late ReviewCartProvider reviewCartProvider;

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    double totalPrice = reviewCartProvider.getTotalPrice();
    double discount = 20;
    double discountValue =
        totalPrice > 1000 ? (totalPrice * discount) / 100 : 0;
    double shippingCharge = 30;
    double total = totalPrice > 1000 ? totalPrice - discountValue : totalPrice;

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : Color.fromARGB(221, 30, 29, 29);

    onGooglePayResult(paymentResult) {
      reviewCartProvider.reviewCartDeleteAll();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return SuccessfulPayment(
          title: "Payment Successful!",
          total: "${total + shippingCharge}",
        );
      }));
    }

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 3, 46, 82)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? Color.fromARGB(255, 3, 46, 82)
            : Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Payment Summery",
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.normal,
              fontFamily: "Circular"),
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
          : Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 23),
                            child: Text("Total Amount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                    fontSize: 19)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 55),
                            child: Text("\u20B9 ${total + shippingCharge}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Circular",
                                    color: themeProvider.isDarkMode
                                        ? Colors.amber
                                        : Color.fromARGB(255, 18, 79, 132),
                                    fontSize: 24)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {},
                        child: paymentType == PaymentOptions.OnlinePayment
                            ? Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: GooglePayButton(
                                  paymentConfigurationAsset:
                                      'sample_payment_configuration.json',
                                  paymentItems: [
                                    PaymentItem(
                                      label: 'Total Amount',
                                      amount: "${total + shippingCharge}",
                                      status: PaymentItemStatus.final_price,
                                    )
                                  ],

                                  width: RawGooglePayButton.minimumButtonWidth,
                                  height: 55,
                                  type: GooglePayButtonType.pay,
                                  onPaymentResult: onGooglePayResult,
                                ),
                              )
                            : GestureDetector(
                                onTap: (() {
                                  if (paymentType == PaymentOptions.Cash) {
                                    reviewCartProvider.reviewCartDeleteAll();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return SuccessfulPayment(
                                        title: "Order Placed!",
                                        total: "${total + shippingCharge}",
                                      );
                                    }));
                                  } else {}
                                }),
                                child: Container(
                                  height: 50,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 15, 102, 173),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "Place Order",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: "Circular",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      body: networkStatus == NetworkStatus.Offline
          ? NoInternetWidget()
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    AddressDetailsWidget(
                        name:
                            "${widget.deliveryAddressList!.firstName} ${widget.deliveryAddressList!.lastName}",
                        address:
                            "${widget.deliveryAddressList!.street},${widget.deliveryAddressList!.society},${widget.deliveryAddressList!.landMark},${widget.deliveryAddressList!.city},${widget.deliveryAddressList!.pincode}",
                        number: "${widget.deliveryAddressList!.phone}",
                        addressType: widget.deliveryAddressList!.addressType ==
                                "AddressType.Home"
                            ? "Home"
                            : widget.deliveryAddressList!.addressType ==
                                    "AddressType.Work"
                                ? "Work"
                                : "Other"),
                    Divider(),
                    ExpansionTile(
                      iconColor: themeProvider.isDarkMode
                          ? Colors.amber
                          : Colors.black,
                      children:
                          reviewCartProvider.getreviewCartDataList.map((e) {
                        return OrderItem(
                          reviewCartModel: e,
                        );
                      }).toList(),
                      title: Text(
                        "No. of Items ${reviewCartProvider.getreviewCartDataList.length} ",
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.deepOrangeAccent
                              : Colors.black,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text(
                        "Sub Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      trailing: Text(
                        "\u20B9" + "${totalPrice + shippingCharge}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text(
                        "Shipping Charge",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.grey[600]),
                      ),
                      trailing: Text(
                        "\u20B9" + "${shippingCharge}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text(
                        "Discount",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.grey[600]),
                      ),
                      trailing: Text(
                        "\u20B9${discountValue}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ),
                    Divider(),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Payment Type",
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
                              value: PaymentOptions.Cash,
                              title: Text(
                                "Cash",
                                style: TextStyle(
                                    fontFamily: "Circluar",
                                    fontWeight: FontWeight.normal,
                                    color: themeProvider.isDarkMode
                                        ? Colors.pink
                                        : Colors.blue,
                                    fontSize: 20),
                              ),
                              groupValue: paymentType,
                              onChanged: (PaymentOptions? value) {
                                setState(() {
                                  paymentType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              value: PaymentOptions.OnlinePayment,
                              title: Text(
                                "Online Payment",
                                style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? Colors.pink
                                        : Colors.blue,
                                    fontFamily: "Circluar",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              groupValue: paymentType,
                              onChanged: (PaymentOptions? value) {
                                setState(() {
                                  paymentType = value!;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }),
    );
  }
}
