import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';
import 'PageRistoranti.dart';
import 'RestaurantDetail.dart';
import 'models/Restaurant.dart';

class PageSearch extends StatefulWidget {
  final User? user;
  final Stream<List<RestaurantModel>> restaurantList;

  const PageSearch({super.key, this.user, required this.restaurantList});

  @override
  _PageSearchState createState() => _PageSearchState(user, restaurantList);
}

class _PageSearchState extends State<PageSearch> {
  final User? user;

  Stream<List<RestaurantModel>> restaurantList;

  _PageSearchState(this.user, this.restaurantList);

  @override
  void initState() {
    super.initState();
  }

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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PageIntro()));
        break;
    }
  }

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBarCustom(onSearch: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: StreamBuilder(
                    stream: restaurantList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<RestaurantModel>> snapshot) {
                      if (searchText.isEmpty) {
                        return const Text(
                          "Inserisci una lettera/parola chiave per cercare dei ristoranti.",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.39,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return snapshot.data![index].nomeR
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase())
                                      ? InkWell(
                                          child: CardRistorante(
                                              restaurant:
                                                  snapshot.data![index]),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RestaurantDetail(
                                                          snapshot.data![index],
                                                          user)),
                                            );
                                          },
                                        )
                                      : Container();
                                }),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                              "Errore durante il caricamento dei dati.");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }
                    }),
              )
            ],
          ),
        ),
        appBar: const CustomAppBar(
          pageName: 'Cerca ristoranti',
          backArrow: true,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped));
  }
}
