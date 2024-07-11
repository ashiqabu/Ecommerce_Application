// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_cyra/core/constant.dart';
import 'package:test_cyra/core/error_indicator_widget.dart';
import 'package:test_cyra/models/category_model_page.dart';
import 'package:test_cyra/models/products_model_page.dart';
import 'package:test_cyra/screens/category_products_page.dart';
import 'package:test_cyra/screens/drawer_page.dart';
import 'package:test_cyra/screens/product_full_details_page.dart';
import 'package:test_cyra/web-services/web_service_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('Do you want to Exit'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: cardColor,
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text('E-Commerce'),
          backgroundColor: fillColor,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight(5),
              Text(
                'Category',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
              ),
              FutureBuilder<List<CategoryModel>?>(
                future: Websevices().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ErrorIndicatorWidget(
                      errorMessage: 'Loading..',
                    );
                  } else if (snapshot.hasError) {
                    return ErrorIndicatorWidget(
                      errorMessage: 'Error: ${snapshot.error}',
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SizedBox(
                      height: 70,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryProductScreen(
                                              catid: snapshot.data![index].id,
                                              catname: snapshot
                                                  .data![index].category)));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    color: cardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(iconsList[index]),
                                          kWidth(5),
                                          Text(snapshot.data![index].category),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return ErrorIndicatorWidget(
                      errorMessage: 'Error: ${snapshot.error}',
                    );
                  }
                },
              ),
              Text(
                'Most searched items',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
              ),
              kHeight(5),
              FutureBuilder<List<ProductModel>?>(
                  future: Websevices().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ErrorIndicatorWidget(
                        errorMessage: 'Loading..',
                      );
                    } else if (snapshot.hasError) {
                      return ErrorIndicatorWidget(
                        errorMessage: 'Error: ${snapshot.error}',
                      );
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: MasonryGridView.builder(
                          itemCount: snapshot.data!.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                              description: product.description,
                                              name: product.productname,
                                              id: product.id,
                                              price: product.price.toString(),
                                              image: Websevices()
                                                      .imageUrlproducts +
                                                  product.image,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              minHeight: 100, maxHeight: 250),
                                          child: Image(
                                            image: NetworkImage(
                                                Websevices().imageUrlproducts +
                                                    product.image),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      product.productname,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Rs.${product.price.toString()}',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return ErrorIndicatorWidget(
                        errorMessage: 'Error: ${snapshot.error}',
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
