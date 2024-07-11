import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_cyra/core/constant.dart';

class SuccsessScreen extends StatelessWidget {
  const SuccsessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(width: 200, 'animation/WdXBKIAKKK.json'),
            kHeight(10),
            const Text(
              'Order Taken',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            kHeight(5),
            const Text(
                textAlign: TextAlign.center,
                'Your order has been placed and will be delivered shortly...'),
            kHeight(20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/orderDtailsScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: fillColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Set your desired border radius here
                  ),
                ),
                child: const Text(
                  'Track order',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            kHeight(20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Set your desired border radius here
                  ),
                ),
                child: const Text(
                  'Continue shopping',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
