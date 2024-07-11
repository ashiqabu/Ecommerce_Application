import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cyra/core/constant.dart';
import 'package:test_cyra/core/error_indicator_widget.dart';
import 'package:test_cyra/web-services/web_service_page.dart';

class OrderDtailsScreen extends StatefulWidget {
  const OrderDtailsScreen({super.key});

  @override
  State<OrderDtailsScreen> createState() => _OrderDtailsScreenState();
}

class _OrderDtailsScreenState extends State<OrderDtailsScreen> {
  String? username;
  @override
  void initState() {
    super.initState();
    _loadUsername();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fillColor,
        centerTitle: true,
        title: Text(
          'Ordered List',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: fontSize),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: FutureBuilder(
          future: Websevices().fetchOrderDetails(username.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    log('total length ${snapshot.data!.length.toString()}');
                    final orderDetails = snapshot.data![index];
                    return Card(
                      child: ExpansionTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat.yMMMEd().format(orderDetails.date),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(orderDetails.paymentmethod,
                                style: const TextStyle(fontSize: 10)),
                            Text(
                              orderDetails.totalamount.toString(),
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 13),
                            )
                          ],
                        ),
                        children: [
                          ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image(
                                                    image: NetworkImage(
                                                        Websevices()
                                                                .imageUrlproducts +
                                                            orderDetails
                                                                .products[index]
                                                                .image)),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(orderDetails
                                                  .products[index].productname),
                                              Text(
                                                '${orderDetails.products[index].price.toString()} /-',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            '${orderDetails.products[index].quantity} X',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: ((context, index) {
                                return kHeight(5);
                              }),
                              itemCount: orderDetails.products.length)
                        ],
                      ),
                    );
                  });
            } else {
              return const ErrorIndicatorWidget(errorMessage: 'Loading');
            }
          }),
    );
  }
}
