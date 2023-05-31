import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

import 'ChipController.dart';
import 'FirebaseControllerMenu.dart';
import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';
import 'PageRistoranti.dart';
import 'models/Product.dart';
import 'models/Restaurant.dart';

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
  late FirebaseControllerMenu firebaseController;

  _RestaurantDetailState(this.restaurant, this.user);

  final ChipControllerMenu chipController = Get.put(ChipControllerMenu());

  final List<String> _chipLabel = [
    'Bevande',
    'Antipasti',
    'Primi',
    'Secondi',
    'Contorni',
    'Dolci',
  ];

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

  @override
  void initState() {
    super.initState();
    firebaseController = Get.put(FirebaseControllerMenu(restaurant));
  }

  @override
  void dispose() {
    Get.delete<FirebaseControllerMenu>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(pageName: 'Ristoranti', backArrow: true),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: Column(children: [
          const SizedBox(height: 20),
          Text(
            restaurant.nomeR.toString(),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.red)),
            elevation: 5,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder(
                    future: FirebaseStorage.instance
                        .ref(restaurant.imageR)
                        .getDownloadURL(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Row(
                      children: [
                        const Text(
                          "Descrizione: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          restaurant.descrizioneR,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Indirizzo: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          restaurant.indirizzoR,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Cucina: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          restaurant.tipoCiboR,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Telefono: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          restaurant.telefonoR,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
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
            'Menù',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
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
                      firebaseController.getMenuData(
                          FilterMenu.values[chipController.selectedChip]);
                    });
              }))),
          const SizedBox(height: 20),
          Obx(() => Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: firebaseController.menuList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardProduct(
                        product: firebaseController.menuList[index]);
                  },
                ),
              ))
        ]));
  }
}
