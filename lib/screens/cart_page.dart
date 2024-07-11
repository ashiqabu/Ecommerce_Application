import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cyra/core/alert_message.dart';
import 'package:test_cyra/core/constant.dart';
import 'package:test_cyra/provider/cart_provider_page.dart';
import 'package:test_cyra/screens/checkout_page.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  List<CartProduct> cartList = [];
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: fillColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          title: Text(
            'Cart page',
            style: TextStyle(fontSize: fontSize),
          ),
          actions: [
            context.watch<Cart>().getItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: fillColor,
                            title: const Text('Clear Cart!..'),
                            content: const Text(
                                'Do you want to clear all items from Cart List'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<Cart>().clearCart();
                                  Navigator.of(context).pop();
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
                    },
                    icon: const Icon(Icons.delete),
                  )
          ]),
      body: context.watch<Cart>().getItems.isEmpty
          ? const Center(
              child: Text(
              'Cart is Empty....',
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
          : Consumer<Cart>(
              builder: (context, ref, child) {
                cartList = ref.getItems;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ref.count,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Image(
                                image: NetworkImage(
                                    ref.getItems[index].imageUrls)),
                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              ref.getItems[index].name,
                              style: const TextStyle(fontSize: 12),
                            ),
                            subtitle: Text(
                              ref.getItems[index].price.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                            ),
                            trailing: Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: fillColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cartList[index].qty == 1
                                            ? ref.removeItem(cartList[index])
                                            : ref.decreament(
                                                ref.getItems[index]);
                                      },
                                      icon: cartList[index].qty == 1
                                          ? const Icon(Icons.delete)
                                          : const Icon(Icons.remove)),
                                  CircleAvatar(
                                      radius: 12,
                                      child: Center(
                                          child: Text(ref.getItems[index].qty
                                              .toString()))),
                                  IconButton(
                                      onPressed: () {
                                        ref.increament(ref.getItems[index]);
                                      },
                                      icon: const Icon(Icons.add))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total : ${context.watch<Cart>().totalPrice.toString()}/-',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(5),
              overlayColor: MaterialStateProperty.all(Colors.black),
              splashColor: (Colors.black),
              onTap: () {
                
                cartList.isEmpty
                    ? showCustomSnackBar(
                        context, 'Cart is Empty!....', Colors.red)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                                  cart: cartList,
                                )));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: fillColor,
                ),
                width: MediaQuery.of(context).size.width / 2.2,
                height: 40,
                child: const Center(
                    child: Text(
                  'Order Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
