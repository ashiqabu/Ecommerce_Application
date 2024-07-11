import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_cyra/core/constant.dart';
import 'package:test_cyra/core/error_indicator_widget.dart';
import 'package:test_cyra/screens/product_full_details_page.dart';
import 'package:test_cyra/web-services/web_service_page.dart';

// ignore: must_be_immutable
class CategoryProductScreen extends StatefulWidget {
  String catname;
  int catid;
  CategoryProductScreen(
      {super.key, required this.catid, required this.catname});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    log('categoryname  =${widget.catname}');
    log('categoryname  =${widget.catid}');
    return Scaffold(
      backgroundColor: cardColor,
      appBar: AppBar(
        backgroundColor: fillColor,
        centerTitle: true,
        title: Text(
          'Sort List of ${widget.catname}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: fontSize),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
          future: Websevices().fetchCatProducts(widget.catid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ErrorIndicatorWidget(errorMessage: 'Loading');
            } else if (snapshot.hasData || snapshot.data!.isNotEmpty) {
              return MasonryGridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                      description: data.description,
                                      name: data.productname,
                                      id: data.id,
                                      price: data.price.toString(),
                                      image: Websevices().imageUrlproducts +
                                          data.image,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                              data.image),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data.productname,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Rs :${data.price}',
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
                            )),
                      ),
                    );
                  });
            }
            return ErrorIndicatorWidget(
                errorMessage: snapshot.error.toString());
          }),
    );
  }
}
