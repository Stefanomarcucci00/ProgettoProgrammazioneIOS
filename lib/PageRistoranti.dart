import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';
import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';
import 'RestaurantDetail.dart';

class PageRistoranti extends StatefulWidget {
  final User? user;

  const PageRistoranti({super.key, required User? user}) : this.user = user;

  @override
  _PageRistorantiState createState() => _PageRistorantiState(user);
}

class _PageRistorantiState extends State<PageRistoranti> {
  late Future<List<RestaurantModel>> restaurantList;
  late Future<List<RestaurantModel>> restaurantListRating;

  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  final User? user;

  _PageRistorantiState(this.user);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PageRistoranti(user: user)));
        break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PageProfilo(
                      user: user,
                    )));
        break;
      case 2:
        FirebaseAuth.instance.signOut();
        Fluttertoast.showToast(
            msg: "Logout effettuato con successo.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PageIntro()));
        break;
    }
  }

  @override
  void initState() {
    restaurantList = getRestaurantList("all");
    restaurantListRating = getRestaurantList("rating");
    super.initState();
  }

  Future<List<RestaurantModel>> getRestaurantList(String filter) async {
    final List<RestaurantModel> restaurantList =
        []; // lista di ristoranti vuota
    final snapshot = await FirebaseDatabase.instance.ref('Ristoranti').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final restaurant = RestaurantModel.fromMap(value);
      if (filter == "rating") {
        if (restaurant.ratingR > 3.5) {
          restaurantList.add(restaurant);
        }
      } else {
        restaurantList.add(restaurant);
      }
    });

    return restaurantList; // ritorna la lista di ristoranti
  }

  Widget build(BuildContext context) {
    //CI FORNISCE height e width della pagina
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(pageName: 'Ristoranti', backArrow: false),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          SearchBarCustom(size: size),
          const Text(
            "Più votati",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20.0),
          SizedBox(
            child: FutureBuilder(
                future: restaurantListRating,
                builder: (BuildContext context,
                    AsyncSnapshot<List<RestaurantModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.39,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: CardRistorante(
                                    copertina: snapshot.data![index].imageR,
                                    nomeRist: snapshot.data![index].nomeR,
                                    tipoCibo: snapshot.data![index].tipoCiboR,
                                    rating: snapshot.data![index].ratingR
                                        .toString(),
                                    descrizione:
                                        snapshot.data![index].descrizioneR),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RestaurantDetail(
                                            snapshot.data![index], user)),
                                  );
                                },
                              );
                            }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                        "Errore durante il caricamento dei dati.");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
          const SizedBox(width: 20.0),
          const Text(
            "Tutti",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20.0),
          SizedBox(
            child: FutureBuilder(
                future: restaurantList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<RestaurantModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.39,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: CardRistorante(
                                    copertina: snapshot.data![index].imageR,
                                    nomeRist: snapshot.data![index].nomeR,
                                    tipoCibo: snapshot.data![index].tipoCiboR,
                                    rating: snapshot.data![index].ratingR
                                        .toString(),
                                    descrizione:
                                        snapshot.data![index].descrizioneR),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RestaurantDetail(
                                            snapshot.data![index], user)),
                                  );
                                },
                              );
                            }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                        "Errore durante il caricamento dei dati.");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          )
        ]),
      ),
    );
  }
}
