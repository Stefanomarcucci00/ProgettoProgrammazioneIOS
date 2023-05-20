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
  final Future<List<RestaurantModel>> restaurantList;

  const PageSearch({super.key, this.user, required this.restaurantList});

  @override
  _PageSearchState createState() => _PageSearchState(user, restaurantList);
}

class _PageSearchState extends State<PageSearch> {
  final User? user;

  Future<List<RestaurantModel>> restaurantList;
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
  final searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBarCustom(
                searchController: searchController,
                size: size,
                onSearch: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: restaurantList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<RestaurantModel>> snapshot) {
                      if (snapshot.hasData) {
                        final filteredRestaurants = snapshot.data!.where((restaurant) =>
                            restaurant.nomeR.toLowerCase().contains(query.toLowerCase())
                        ).toList();
                        return Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.39,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filteredRestaurants.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    child: CardRistorante(
                                        copertina: filteredRestaurants[index].imageR,
                                        nomeRist: filteredRestaurants[index].nomeR,
                                        tipoCibo:
                                        filteredRestaurants[index].tipoCiboR,
                                        rating: filteredRestaurants[index].ratingR
                                            .toString(),
                                        descrizione:
                                        filteredRestaurants[index].descrizioneR),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RestaurantDetail(
                                                    filteredRestaurants[index],
                                                    user)),
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
