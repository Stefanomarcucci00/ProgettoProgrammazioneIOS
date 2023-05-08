import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  late Future<List<RestaurantModel>>
      restaurantList; // definisce una variabile Future di tipo List<RestaurantModel>

  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    restaurantList = getRestaurantList();
  }

  Future<List<RestaurantModel>> getRestaurantList() async {
    List<RestaurantModel> restaurantList = []; // lista di ristoranti vuota

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Ristoranti')
        .get(); // prende tutti i documenti dalla collezione 'ristoranti'

    querySnapshot.docs.forEach((doc) {
      // cicla su tutti i documenti
      String image = doc.get('imageR');
      String nome = doc.get('nomeR'); // prende il valore del campo 'nome'
      String descrizione =
          doc.get('descrizioneR'); // prende il valore del campo 'descrizione'
      String indirizzo = doc.get('indirizzoR');
      String orarioinizio = doc.get('orarioinizioR');
      String orariofine = doc.get('orariofineR');
      String telefono = doc.get('telefonoR');
      String tipoCibo = doc.get('tipoCiboR');
      String vegan = doc.get('veganR');
      String rating = doc.get('ratingR');
      String id = doc.get('idR');
      String proprietario = doc.get('proprietarioR');

      RestaurantModel restaurant = RestaurantModel(
          imageR: image,
          nomeR: nome,
          descrizioneR: descrizione,
          indirizzoR: indirizzo,
          orarioinizioR: orarioinizio,
          orariofineR: orariofine,
          telefonoR: telefono,
          tipoCiboR: tipoCibo,
          veganR: vegan,
          ratingR: rating,
          idR: id,
          proprietarioR:
              proprietario); // crea un nuovo oggetto RestaurantModel con i dati presi dal database
      restaurantList
          .add(restaurant); // aggiunge l'oggetto alla lista di ristoranti
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
