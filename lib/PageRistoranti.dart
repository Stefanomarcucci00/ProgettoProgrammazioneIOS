import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

class PageRistoranti extends StatefulWidget {
  final User? user;

  const PageRistoranti({super.key, required User? user}) : this.user = user;

  @override
  _PageRistorantiState createState() => _PageRistorantiState(user);
}

class _PageRistorantiState extends State<PageRistoranti> {
  late Future<List<RestaurantModel>>
      restaurantList; // definisce una variabile Future di tipo List<RestaurantModel>

  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  _PageRistorantiState(this.user);

  final User? user;

  @override
  void initState() {
    restaurantList = getRestaurantList();
    super.initState();
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
    String email = user!.email.toString();

    return Scaffold(
      appBar: const CustomAppBar( pageName: 'Ristoranti', backArrow: false),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 16,
          ),
          /*
          Text(email),
          const SizedBox(
            height: 16,
          ),
           */
          SizedBox(
            height: 400,
            child: FutureBuilder(
              future: restaurantList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<RestaurantModel>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(snapshot.data![index].nomeR),
                            subtitle: Text(snapshot.data![index].descrizioneR),
                          );
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text("Errore durante il caricamento dei dati.");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
