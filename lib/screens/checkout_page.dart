// ignore_for_file: use_build_context_synchronously, must_be_immutable, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cyra/core/constant.dart';
import 'package:test_cyra/core/error_indicator_widget.dart';
import 'package:test_cyra/models/user_model_page.dart';
import 'package:test_cyra/provider/cart_provider_page.dart';
import 'package:test_cyra/screens/razorpay_page.dart';
import 'package:test_cyra/web-services/web_service_page.dart';

class CheckoutScreen extends StatefulWidget {
  List<CartProduct> cart;
  CheckoutScreen({super.key, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedValue = 1;
  String? username;
  String? name, phone, address;
  String? paymentMethode = 'Cash on delivery';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
    if (kDebugMode) {
      print('Username ===${username.toString()}');
    }
  }

  orderPlace(List<CartProduct> cart, String amount, String paymentMethode,
      String date, String name, String address, String phone) async {
    String jsonData = jsonEncode(cart);

    final vm = Provider.of<Cart>(context, listen: false);
    final response =
        await http.post(Uri.parse("${Websevices.mainURL}order.php"), body: {
      'username': username,
      "amount": amount,
      "paymentmethod": paymentMethode,
      "date": date,
      "quantity": vm.count.toString(),
      "cart": jsonData,
      "name": name,
      "address": address,
      "phone": phone
    });
    if (response.statusCode == 200) {
      if (response.body.contains('Success')) {
        vm.clearCart();

        Navigator.pushReplacementNamed(context, '/succsessScreen');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fillColor,
        title: Text(
          'CheckOut Page',
          style: TextStyle(fontSize: fontSize),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<UserModel>(
                future: Websevices().fetchUser(username.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    name = snapshot.data!.name;
                    phone = snapshot.data!.phone;
                    address = snapshot.data!.address;

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Name : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(name.toString()),
                              ],
                            ),
                            kHeight(10),
                            Row(
                              children: [
                                const Text(
                                  'Phone : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(phone.toString()),
                              ],
                            ),
                            kHeight(10),
                            Row(
                              children: [
                                const Text(
                                  'Address : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      maxLines: 4,
                                      address.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const ErrorIndicatorWidget(
                      errorMessage: 'Loading',
                    );
                  }
                }),
          ),
          kHeight(10),
          RadioListTile(
            activeColor: fillColor,
            value: 1,
            groupValue: selectedValue,
            onChanged: (int? value) {
              setState(() {
                selectedValue = value!;
                paymentMethode = 'Cash on delivery';
              });
            },
            title: const Text('Cash on Delivery'),
            subtitle: const Text('pay cash at home'),
          ),
          RadioListTile(
            activeColor: fillColor,
            value: 2,
            groupValue: selectedValue,
            onChanged: (int? value) {
              setState(() {
                selectedValue = value!;
                paymentMethode = 'Online';
              });
            },
            title: const Text('Pay Online'),
            subtitle: const Text('pay through online methode'),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          overlayColor: MaterialStateProperty.all(Colors.black),
          splashColor: (Colors.black),
          onTap: () {
            final vm = Provider.of<Cart>(context, listen: false);
            String dateTime = DateTime.now().toString();
            if (paymentMethode == "Online") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RazorPayScreen(
                          address: address.toString(),
                          amount: vm.totalPrice.toString(),
                          paymentmeothde: paymentMethode.toString(),
                          name: name.toString(),
                          date: dateTime.toString(),
                          phone: phone.toString(),
                          cart: widget.cart)));
            } else {
              orderPlace(widget.cart, vm.totalPrice.toString(), paymentMethode!,
                  dateTime, name!, address!, phone!);
              log('dateeeeee....$dateTime');
              log('data.....${widget.cart}');
              log('total amount...${vm.totalPrice}');
              log('paymentmethod.......$paymentMethode');
              log('nameeee...$name');
              log('Address.....$address');
              log('phone.......$phone');
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: fillColor,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: const Center(
                child: Text(
              'Check Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
