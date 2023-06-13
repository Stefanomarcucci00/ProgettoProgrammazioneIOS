import 'package:flutter/cupertino.dart';
import 'package:progetto_programmazione_ios/models/CartProduct.dart';

// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
/* Questa classe permette ai prodotti dentro al carrello di essere aggiunti
alla lista temporaneamente, fin quando non si chiude l'applicazione */

class CartProvider extends ChangeNotifier {
  List<CartProductModel> _cartProducts = [];

  List<CartProductModel> get cartProducts => _cartProducts;

  // Funzione che permette di aggiungere alla lista un nuovo prodotto
  void addProduct(CartProductModel product) {
    _cartProducts.add(product);
    notifyListeners();
  }

  // Funzione che permette di eliminare un determinato prodotto all'interno della lista
  void removeProduct(CartProductModel product) {
    _cartProducts.remove(product);
    notifyListeners();
  }

  // Funzione che elimina l'interno contenuto della lista
  void clearData() {
    _cartProducts.clear();
    notifyListeners();
  }

}
