import 'dart:developer';

import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<WhisModel> _list = [];

  List<WhisModel> get getItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  void addItem(
    int id,
    String name,
    String imageUrls,
    double price,
  ) {
    final product = WhisModel(id: id, imageUrls: imageUrls, name: name, price: price);
    _list.add(product);
    notifyListeners();
    log('wish item added*******');
  }

  void removeItem(int id) {
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}

class WhisModel {
  int id;
  String name;
  String imageUrls;
  double price;

  WhisModel({
    required this.id,
    required this.imageUrls,
    required this.name,
    required this.price,
  });

  factory WhisModel.fromJson(Map<String, dynamic> json) => WhisModel(
        id: json["id"],
        imageUrls: json["image"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": imageUrls,
      };
}
