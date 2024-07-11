// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cyra/provider/cart_provider_page.dart';
import 'package:test_cyra/web-services/web_service_page.dart';

class RazorPayScreen extends StatefulWidget {
  List<CartProduct> cart;
  String amount, paymentmeothde, date, name, address, phone;
  RazorPayScreen(
      {super.key,
      required this.address,
      required this.amount,
      required this.paymentmeothde,
      required this.name,
      required this.date,
      required this.phone,
      required this.cart});

  @override
  State<RazorPayScreen> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  TextEditingController textcntrl = TextEditingController();
  Razorpay? razorpay;
  int selectedValue = 1;
  String? username;
  @override
  void initState() {
    super.initState();
    flutterpayment('aaabbb', 10);
    _loadUsername();
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlepaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalwallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay!.clear();
  }

  void flutterpayment(String orderId, int t) {
    log('inside functuion');
    var options = {
      "key": "rzp_test_IGhdfrMPYIDCPR",
      "amount": t * 100,
      "name": 'vahid',
      "currency": "INR",
      "description": "maligai",
      "external": {
        "wallets": ["paytm"]
      },
      "retry": {"enabled": true, "max_count": 1},
      "send_sms_hash": true,
      "prefill": {"contact": "7356301307", "email": "ameen123@gmail.com"}
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      debugPrint('Error:e');
    }
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });

    log('username : ${username.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }

  void _handlepaymentSuccess(PaymentSuccessResponse response) {
    response.orderId;
    successMethode(response.paymentId.toString());
  }

  void _handlepaymentError(PaymentFailureResponse response) {
    log("error${response.message}");
  }

  void _handleExternalwallet(PaymentFailureResponse response) {
    log("error${response.message}");
  }

  void successMethode(String paymentId) {
    log("success$paymentId");
    orderPlace(widget.cart, widget.amount.toString(), widget.paymentmeothde,
        widget.date, widget.name, widget.address, widget.phone);
  }

  orderPlace(List<CartProduct> cart, String amount, String paymentMethode,
      String date, String name, String address, String phone) async {
    try {
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
    } catch (e) {
      log(e.toString());
    }
  }
}
