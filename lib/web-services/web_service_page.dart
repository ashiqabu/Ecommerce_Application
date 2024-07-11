import 'dart:convert';
import 'dart:developer';
import 'package:test_cyra/models/category_model_page.dart';
import 'package:http/http.dart' as http;
import 'package:test_cyra/models/order_model_page.dart';
import 'package:test_cyra/models/products_model_page.dart';
import 'package:test_cyra/models/user_model_page.dart';

class Websevices {
  final imageUrlproducts = 'http://bootcamp.cyralearnings.com/products/';
  static const mainURL = 'http://bootcamp.cyralearnings.com/';
  static const mainURL1 = 'http://192.168.29.72:8080/ecommerce_workshop/';
  Future<List<CategoryModel>?> fetchCategory() async {
    try {
      final response = await http.get(Uri.parse('${mainURL}getcategories.php'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedJson = jsonDecode(response.body);
        List<CategoryModel> categories =
            parsedJson.map((json) => CategoryModel.fromJson(json)).toList();
        return categories;
      } else {
        throw Exception('Failed to connect API');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to connect API');
    }
  }

  Future<List<ProductModel>?> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('${mainURL}view_offerproducts.php'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedJson = jsonDecode(response.body);
        List<ProductModel> products =
            parsedJson.map((json) => ProductModel.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Failed to connect API');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to connect API');
    }
  }

  Future<List<ProductModel>?> fetchCatProducts(int catid) async {
    try {
      final response = await http.post(
          Uri.parse('${mainURL}get_category_products.php'),
          body: {'catid': catid.toString()});

      if (response.statusCode == 200) {
        final List<dynamic> parsedJson = jsonDecode(response.body);
        List<ProductModel> products =
            parsedJson.map((json) => ProductModel.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Failed to connect API');
      }
    } catch (e) {
      throw Exception('Failed to connect API');
    }
  }

  Future<UserModel> fetchUser(String username) async {
    final respons = await http.post(Uri.parse('${mainURL}get_user.php'),
        body: {'username': username});
    if (respons.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(respons.body));
    } else {
      throw Exception('Failed to connect API');
    }
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    log('username : $username');
    try {
      final response = await http.post(
          Uri.parse('${mainURL}get_orderdetails.php'),
          body: {'username': username.toString()});
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
