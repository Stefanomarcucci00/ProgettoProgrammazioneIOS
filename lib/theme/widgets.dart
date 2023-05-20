import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/PageCarrello.dart';
import 'package:progetto_programmazione_ios/PageQR_Code.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

import '../RestaurantDetail.dart';

class RedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const RedButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Text(buttonText),
    );
  }
}

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final bool enabled;

  const MyTextField(
      {Key? key,
      this.controller,
      required this.hintText,
      required this.obscureText,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        enabled: enabled,
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.red.shade400,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}

class SearchBarCustom extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBarCustom({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                onChanged: onSearch,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  hintText: 'Cerca',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class fakeSearchBarCustom extends StatelessWidget {
  const fakeSearchBarCustom(
      {Key? key, required this.size, required this.enabled})
      : super(key: key);

  final Size size;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                enabled: enabled,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  hintText: 'Cerca',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;
  final bool backArrow;

  const CustomAppBar(
      {super.key, required this.pageName, required this.backArrow});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AppBar(
      automaticallyImplyLeading: backArrow,
      title: Text(pageName),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PageCarrello(user: user))),
          color: Colors.white,
        ),
        IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PageQR_Code(
                        user: user,
                      ))),
          color: Colors.white,
        )
      ],
      backgroundColor: Colors.red,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.red,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Homepage',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'Profilo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout, color: Colors.white),
          label: 'Logout',
        ),
      ],
    );
  }
}

class CardRistorante extends StatelessWidget {
  final RestaurantModel restaurant;

  const CardRistorante({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 160,
          height: MediaQuery.of(context).size.height * 0.39,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: FirebaseStorage.instance
                          .ref(restaurant.imageR)
                          .getDownloadURL(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 150.0,
                            height: 150.0,
                            color: Colors.grey,
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            width: 150.0,
                            height: 150.0,
                            color: Colors.red,
                          );
                        } else {
                          return Container(
                            width: 150.0,
                            height: 150.0,
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
                  )),
              Text(
                restaurant.nomeR,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                restaurant.tipoCiboR,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    restaurant.ratingR.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                restaurant.descrizioneR,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final Future<List<RestaurantModel>> restaurantList;
  final User user;
  final String filter;

  const CardList(
      {super.key,
      required this.restaurantList,
      required this.user,
      required this.filter});

  @override
  _CardList createState() =>
      _CardList(restaurantList: restaurantList, user: user, filter: filter);
}

class _CardList extends State<CardList> {
  final Future<List<RestaurantModel>> restaurantList;
  final User user;
  String filter;

  _CardList(
      {required this.restaurantList, required this.user, required this.filter});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
          future: restaurantList,
          builder: (BuildContext context,
              AsyncSnapshot<List<RestaurantModel>> snapshot) {
            if (snapshot.hasData) {
              var filteredList = [];

              switch (filter) {
                case 'Empty':
                  filteredList = [];
                  break;
                case 'Ratings':
                  filteredList = [];
                  filteredList = snapshot.data!
                      .where((restaurant) => restaurant.ratingR >= 3.5)
                      .toList();
                  break;
                case 'Italiano':
                  filteredList = [];
                  filteredList = snapshot.data!
                      .where((restaurant) =>
                          restaurant.tipoCiboR.contains("Italiano"))
                      .toList();
                  break;
                case 'Pizza':
                  filteredList = [];
                  filteredList = snapshot.data!
                      .where((restaurant) =>
                          restaurant.tipoCiboR.contains("Pizza"))
                      .toList();
                  break;
                case 'Burger':
                  filteredList = [];
                  filteredList = snapshot.data!
                      .where((restaurant) =>
                          restaurant.tipoCiboR.contains("Burger"))
                      .toList();
                  break;
              }

              return Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.39,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return filteredList.isNotEmpty? InkWell(
                          child:
                              CardRistorante(restaurant: filteredList[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestaurantDetail(
                                      filteredList[index], user)),
                            );
                          },
                        ) : Container();
                      }),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("Errore durante il caricamento dei dati.");
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
