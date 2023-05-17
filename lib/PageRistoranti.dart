import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

class PageRistoranti extends StatefulWidget {
  @override
  _PageRistorantiState createState() => _PageRistorantiState();
}

class _PageRistorantiState extends State<PageRistoranti> {
  late Future<List<RestaurantModel>>
      restaurantList; // definisce una variabile Future di tipo List<RestaurantModel>

  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    restaurantList = getRestaurantList();
  }

  Future<List<RestaurantModel>> getRestaurantList() async {
    final List<RestaurantModel> restaurantList =
        []; // lista di ristoranti vuota
    final snapshot = await FirebaseDatabase.instance.ref('Ristoranti').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final restaurant = RestaurantModel.fromMap(value);
      restaurantList.add(restaurant);
    });
    return restaurantList; // ritorna la lista di ristoranti
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<RestaurantModel>>(
        future: restaurantList,
        // passa la variabile Future alla funzione FutureBuilder
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Si è verificato un errore: ${snapshot.error}");
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // mostra un indicatore di caricamento finché la lista non è pronta
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              RestaurantModel restaurant = snapshot
                  .data![index]; // prende l'oggetto RestaurantModel dalla lista
              return ListTile(
                title: Text(restaurant.nomeR),
                subtitle: Text(restaurant.descrizioneR),
              );
            },
          );
        },
      ),
    );
  }
}
