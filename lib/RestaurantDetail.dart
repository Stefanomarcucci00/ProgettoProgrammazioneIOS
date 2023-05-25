import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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

  _RestaurantDetailState(this.restaurant, this.user);

  final FirebaseControllerMenu firebaseController = Get.put(FirebaseControllerMenu());
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
  Widget build(BuildContext context) {
    String imageUrl = restaurant.imageR.toString();

    return Scaffold(
        appBar: const CustomAppBar(pageName: 'Ristoranti', backArrow: true),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: Column(children: [
          Text(
            restaurant.nomeR.toString(),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 16.0),
          Card(
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
                    Text(
                      "Descrizione: ${restaurant.descrizioneR}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Indirizzo: ${restaurant.indirizzoR}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Cucina: ${restaurant.tipoCiboR}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Telefono: ${restaurant.telefonoR}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
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
                      //firebaseController.getMenuData(restaurant,
                      //    FilterMenu.values[chipController.selectedChip]);
                      //firebaseController.onInit();
                    });
              }))),
        ]));
  }
}
