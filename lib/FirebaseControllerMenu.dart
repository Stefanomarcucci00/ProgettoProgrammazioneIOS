import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:progetto_programmazione_ios/ChipController.dart';

import 'models/Product.dart';

// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
/* Questa classe permette all'applicazione di recuperare i dati dei menu
di un ristorante dal database ed aggiungerli ad una lista grazie ad un filtraggio;
inoltre, grazie al ChipController, verranno visualizzati i prodotti che
corrisponderanno alla scelta effettuata */

class FirebaseControllerMenu extends GetxController {
  var menuList = <ProductModel>[].obs;
  dynamic restaurant;

  FirebaseControllerMenu(this.restaurant);

  final ChipControllerMenu _chipController = Get.put(ChipControllerMenu());

  @override
  void onInit() {
    menuList.bindStream(getMenuData( FilterMenu.values[_chipController.selectedChip]));
    super.onInit();
  }

  // Collegamento con il database e filtraggio della lista grazie al parametro passato
  Stream<List<ProductModel>> getMenuData(FilterMenu tipologia) {
    DatabaseReference dbRef = FirebaseDatabase.instance
        .ref('Ristoranti/${restaurant!.idR}/Menu/${tipologia.name.toString()}');

    return dbRef.onValue.map((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>;

      switch (tipologia) {
        case FilterMenu.Bevande:
          List<ProductModel> bevande = [];
          map.forEach((key, value) {
            final product = ProductModel.fromMap(value);
            bevande.add(product);
          });
          return bevande;
        case FilterMenu.Antipasti:
          List<ProductModel> antipasti = [];
          map.forEach((key, value) {
            final product = ProductModel.fromMap(value);
            antipasti.add(product);
          });
          return antipasti;
        case FilterMenu.Primi:
          List<ProductModel> primi = [];
          map.forEach((key, value) {
            final product = ProductModel.fromMap(value);
            primi.add(product);
          });
          return primi;
        case FilterMenu.Secondi:
          List<ProductModel> secondi = [];
          map.forEach((key, value) {
            final product = ProductModel.fromMap(value);
            secondi.add(product);
          });
          return secondi;
        case FilterMenu.Contorni:
          List<ProductModel> contorni = [];
          map.forEach((key, value) {
            final product = ProductModel.fromMap(value);
            contorni.add(product);
          });
          return contorni;
        case FilterMenu.Dolci:
          List<ProductModel> dolci = [];
          map.forEach((key, value) {
            final product = ProductModel.fromMap(value);
            dolci.add(product);
          });
          return dolci;
        default:
          List<ProductModel> products = [];
          return products;
      }
    });
  }
}
