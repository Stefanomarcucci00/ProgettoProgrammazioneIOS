import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';
import 'package:progetto_programmazione_ios/models/User.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  late Future<List<UserModel>>
      userList; // definisce una variabile Future di tipo List<RestaurantModel>

  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    userList = getUserList();
  }

  Future<List<UserModel>> getUserList() async {
    List<UserModel> userList = []; // lista di utenti vuota

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Utenti')
        .get(); // prende tutti i documenti dalla collezione 'utenti'

    querySnapshot.docs.forEach((doc) {
      // cicla su tutti i documenti
      String nome = doc.get('Nome');
      String cognome = doc.get('Cognome'); // prende il valore del campo 'nome'
      String email=doc.get('Email');
      String pwd=doc.get('Password');
      String telefono = doc.get('Telefono');
      String uri = doc.get('Uri');
      String livello = doc.get('Livello');

      UserModel user = UserModel(
          Nome: nome,
          Cognome: cognome,
          Email: email,
          Password: pwd,
          Telefono: telefono,
          Uri: uri,
          Livello: livello ); // crea un nuovo oggetto userModel con i dati presi dal database
          userList
          .add(user); // aggiunge l'oggetto alla lista di ristoranti
    });

    return userList; // ritorna la lista di ristoranti
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserModel>>(
        future: userList,
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
              UserModel user = snapshot
                  .data![index]; // prende l'oggetto RestaurantModel dalla lista
              return ListTile(
                title: Text(user.Nome),
                subtitle: Text(user.Cognome),
              );
            },
          );
        },
      ),
    );
  }
}
