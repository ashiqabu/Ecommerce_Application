import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cyra/core/alert_message.dart';
import 'package:test_cyra/provider/wishList_provider.dart';

class WhisListScreen extends StatelessWidget {
  const WhisListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Wishlist'),
        centerTitle: true,
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlist, child) {
          if (wishlist.getItems.isEmpty) {
            return const Center(
              child: Text(
                'Wishlist is empty...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: wishlist.count,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = wishlist.getItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    wishlist.removeItem(product.id);
                                    showCustomSnackBar(
                                      context,
                                      'Item removed from Wishlist',
                                      Colors.red,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                constraints: const BoxConstraints(
                                  minHeight: 100,
                                  maxHeight:
                                      150, // Adjust this height to fit your needs
                                ),
                                child: Image.network(
                                  product.imageUrls,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rs.${product.price}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
