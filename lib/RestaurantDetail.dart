import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';
import 'PageRistoranti.dart';
import 'models/Restaurant.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RestaurantDetail extends StatefulWidget {
  final RestaurantModel restaurant;
  final User? user;

  const RestaurantDetail(this.restaurant, this.user, {super.key});

  @override
  _RestaurantDetailState createState() =>
      _RestaurantDetailState(restaurant, user);
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final RestaurantModel restaurant;
  final User? user;

  _RestaurantDetailState(this.restaurant, this.user);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageRistoranti(user: user)));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageProfilo(
                      user: user,
                    )));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PageIntro()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = restaurant.imageR.toString();

    return Scaffold(
        appBar: const CustomAppBar(pageName: 'Ristoranti', backArrow: true),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                restaurant.nomeR.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(width: 16.0),
          Card(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: firebase_storage.FirebaseStorage.instance
                            .ref(imageUrl)
                            .getDownloadURL(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: 80.0,
                              height: 80.0,
                              color: Colors.grey,
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              width: 80.0,
                              height: 80.0,
                              color: Colors.red,
                            );
                          } else {
                            return Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  )))
        ]));
  }
}
