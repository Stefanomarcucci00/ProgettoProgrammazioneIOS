import 'package:flutter/cupertino.dart';
import 'package:progetto_programmazione_ios/models/CartProduct.dart';

class CartProvider extends ChangeNotifier {
  List<CartProductModel> _cartProducts = [];

  List<CartProductModel> get cartProducts => _cartProducts;

  void addProduct(CartProductModel product) {
    _cartProducts.add(product);
    notifyListeners();
  }

  void removeProduct(CartProductModel product) {
    _cartProducts.remove(product);
    notifyListeners();
  }

}
