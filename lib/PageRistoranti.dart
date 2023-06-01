
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progetto_programmazione_ios/ChipController.dart';
import 'package:progetto_programmazione_ios/PageSearch.dart';
import 'package:progetto_programmazione_ios/PageRestaurantDetail.dart';
import 'package:progetto_programmazione_ios/FirebaseControllerRestaurants.dart';
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
  final FirebaseControllerRist firebaseController = Get.put(FirebaseControllerRist());
  final ChipController chipController = Get.put(ChipController());

  final List<String> _chipLabel = [
    'Pizza',
    'Burger',
    'Italiano',
    'Cinese',
    'Giapponese',
    'Indiano',
    'Greco',
    'Vegan'
  ];

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(pageName: 'Ristoranti', backArrow: false),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_splash_2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  child: fakeSearchBarCustom(size: size, enabled: false),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageSearch(
                                user: user,
                                restaurantList:
                                    firebaseController.getRestaurantData(Filter.ALL))));
                  }),
              Container(
                height: 1,
                color: Colors.red,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "I PIU' VOTATI",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: firebaseController.restaurantListRating.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: CardRistorante(
                              restaurant:
                                  firebaseController.restaurantListRating[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantDetail(
                                          firebaseController.restaurantListRating[index],
                                          user)),
                            );
                          },
                        );
                      },
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.red,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "CERCA PER TIPOLOGIA",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Wrap(
                  spacing: 20,
                  children: List<Widget>.generate(_chipLabel.length, (index) {
                    return ChoiceChip(
                        labelStyle: const TextStyle(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: const BorderSide(color: Colors.red, width: 0.5),
                        ),
                        backgroundColor: Colors.white,
                        selectedColor: Colors.red.shade100,
                        label: Text(_chipLabel[index]),
                        selected: chipController.selectedChip == index,
                        onSelected: (bool selected) {
                          chipController.selectedChip = selected ? index : 0;
                          firebaseController.onInit();
                          firebaseController.getRestaurantData(
                              Filter.values[chipController.selectedChip]);
                        });
                  }))),
              Obx(() => Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: firebaseController.restaurantList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: CardRistorante(
                              restaurant:
                              firebaseController.restaurantList[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantDetail(
                                          firebaseController.restaurantList[index],
                                          user)),
                            );
                          },
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
