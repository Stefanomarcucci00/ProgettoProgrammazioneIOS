import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:progetto_programmazione_ios/ChipController.dart';
import 'package:progetto_programmazione_ios/models/CartProduct.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

class CartController extends GetxController {

  var cartProductList = <CartProductModel>[].obs;
/*
  UUID DELL'UTENTE PER SCRIVERE SUL CARRELLO
  var String UUID=User as String;
  //UUID PER ACCEDERE AL MENU
  var String R_UUID=FirebaseDatabase.instance;

  @override
  void onInit() {
    cartProductList.bindStream(getCartList(UUID));
    super.onInit();
  }

  Stream<List<CartProductModel>> getCartList(String uuid) {
    //UTENTI --> UUID --> CARRELLO
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('Utenti/$u/Cart');

    return dbRef.onValue.map((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>;


      return cartProductList;

    });

  }
  */
}
