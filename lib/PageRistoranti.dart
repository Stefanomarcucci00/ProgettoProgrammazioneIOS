import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progetto_programmazione_ios/PageSearch.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';
import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';

class PageRistoranti extends StatefulWidget {
  final User? user;

  const PageRistoranti({super.key, this.user});

  @override
  _PageRistorantiState createState() => _PageRistorantiState(user);
}

class _PageRistorantiState extends State<PageRistoranti> {
  late Future<List<RestaurantModel>> restaurantList;

  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  final User? user;

  _PageRistorantiState(this.user);

  int _selectedIndex = 0;

  String filter = '';

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
    Size size = MediaQuery.of(context).size;

    List<String> searchOptions = [
      'Pizza',
      'Burger',
      'Italiano',
      'Cinese',
      'Giapponese',
      'Indiano',
      'Greco',
      'Vegan'
    ];

    return Scaffold(
      appBar: const CustomAppBar(pageName: 'Ristoranti', backArrow: false),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
              child: fakeSearchBarCustom(size: size, enabled: false),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageSearch(
                            user: user, restaurantList: restaurantList)));
              }),
          Container(
            height: 1,
            color: Colors.red,
          ),
          const SizedBox(height: 10.0),
          const Text(
            "TOP RATED",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          CardList(
              restaurantList: restaurantList, user: user!, filter: 'Ratings'),
          const SizedBox(height: 10.0),
          Container(
            height: 1,
            color: Colors.red,
          ),
          const SizedBox(height: 10.0),
          const Text(
            "CERCA PER TIPOLOGIA",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: searchOptions.map((option) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ChoiceChip(
                      label: Text(option),
                      selected: filter == option,
                      onSelected: (isSelected) {
                        setState(() {
                          filter = isSelected ? option : '';
                        });
                      },
                      labelStyle: const TextStyle(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        side: const BorderSide(color: Colors.red, width: 0.5),
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.red.shade100,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CardList(restaurantList: restaurantList, user: user!, filter: filter)
        ]),
      ),
    );
  }
}
