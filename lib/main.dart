import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cyra/provider/cart_provider_page.dart';
import 'package:test_cyra/screens/cart_page.dart';
import 'package:test_cyra/screens/home_page.dart';
import 'package:test_cyra/screens/intro_page.dart';
import 'package:test_cyra/screens/login.dart';
import 'package:test_cyra/screens/order_details_page.dart';
import 'package:test_cyra/screens/register.dart';
import 'package:test_cyra/screens/successfull_page.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Cart())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.orange,
              fontFamily: 'Montserrat', // Set the custom font family globally
            ),
            debugShowCheckedModeBanner: false,
            title: 'Ecommerce Appplication',
            initialRoute: isLoggedIn ? '/home' : '/intro',
            routes: {
              '/intro': (context) => const IntroPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/home': (context) => const HomeScreen(),
              '/cartPage': (context) => CartScreen(),
              '/orderDtailsScreen': (context) => const OrderDtailsScreen(),
               '/succsessScreen': (context) => const SuccsessScreen(),
              // '/checkoutScreen': (context) =>  CheckoutScreen(cart: [],),
              //'/categoryProductScreen': (context) =>  CategoryProductScreen(),
            },
          );
        }
      },
    );
  }
}
