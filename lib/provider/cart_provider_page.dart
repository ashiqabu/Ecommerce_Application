import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final List<CartProduct> _list = [];
  List<CartProduct> get getItems {
    return _list;
  }

  double? get totalPrice {
    var total = 0.0;
    for (var item in _list) {
      total = total + (item.price * item.qty);
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  bool itemExists(int id) {
    return _list.any((item) => item.id == id);
  }

  void addItem(int id, String name, double price, int qty, String imageUrls) {
    final product = CartProduct(
        id: id, imageUrls: imageUrls, name: name, price: price, qty: qty);
    _list.add(product);
    notifyListeners();
  }

  void increament(CartProduct product) {
    product.increase();
    notifyListeners();
  }

  void decreament(CartProduct product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(CartProduct product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}

class CartProduct {
  int id;
  String name;
  String imageUrls;
  double price;
  int qty = 1;

  CartProduct(
      {required this.id,
      required this.imageUrls,
      required this.name,
      required this.price,
      required this.qty});

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
      id: json["id"],
      imageUrls: json["image"],
      name: json["name"],
      price: json["price"],
      qty: json["qty"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "price": price, "image": imageUrls, "qty": qty};

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}
