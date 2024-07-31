// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cyra/core/constant.dart';
import 'package:test_cyra/core/error_indicator_widget.dart';
import 'package:test_cyra/provider/cart_provider_page.dart';
import 'package:test_cyra/provider/wishList_provider.dart';
import 'package:test_cyra/web-services/web_service_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  String? phone, name, address, username;

  _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });

    log('Username ===${username.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: Websevices().fetchUser(username.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            name = snapshot.data!.name;
            address = snapshot.data!.address;
            phone = snapshot.data!.phone;

            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          phone.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          address.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Badge(
                        isLabelVisible: context.read<Cart>().getItems.isEmpty
                            ? false
                            : true,
                        label: Text(
                            context.read<Cart>().getItems.length.toString()),
                        child: const Icon(Icons.shopping_cart)),
                    title: const Text('Cart Page'),
                    onTap: () {
                      Navigator.pushNamed(context, '/cartPage');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text('Order Details'),
                    onTap: () {
                      Navigator.pushNamed(context, '/orderDtailsScreen');
                    },
                  ),
                  ListTile(
                    leading: Badge(
                        isLabelVisible:
                            context.read<WishlistProvider>().getItems.isEmpty
                                ? false
                                : true,
                        label: Text(context
                            .read<WishlistProvider>()
                            .getItems
                            .length
                            .toString()),
                        child: const Icon(Icons.favorite)),
                    title: const Text('WhishList'),
                    onTap: () {
                      Navigator.pushNamed(context, '/whisListScreen');
                    },
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text('Log Out'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: fillColor,
                              title: const Text('Logout!..'),
                              content: const Text('Do you want to logout...'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool("isLoggedIn", false);

                                    Navigator.pushReplacementNamed(
                                        context, '/intro');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: const Text('Yes'),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: const Text('No'),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ],
              ),
            );
          } else {
            return const ErrorIndicatorWidget(errorMessage: 'Loading');
          }
        },
      ),
    );
  }
}
