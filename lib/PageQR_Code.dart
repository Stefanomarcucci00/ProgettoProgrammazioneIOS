import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';
import 'PageRistoranti.dart';
import 'models/User.dart';

class PageQR_Code extends StatefulWidget {
  final User? user;

  const PageQR_Code({super.key, this.user});

  @override
  _PageQR_CodeState createState() => _PageQR_CodeState(user);
}

class _PageQR_CodeState extends State<PageQR_Code> {
  final User? user;
  late Future<UserModel> usermodel;

  _PageQR_CodeState(this.user);

  List<dynamic>? mapData;

  @override
  void initState() {
    super.initState();
    fetchMapData().then((value) {
      setState(() {
        mapData = value;
      });
    });
  }

  Future<List<dynamic>> fetchMapData() async {
    final userDB =
        await FirebaseDatabase.instance.ref('Utenti/${user!.uid}/Cart').get();
    final map = userDB.value as List<dynamic>;
    return map;
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

  Widget generateQRCode() {
    String mapJson = jsonEncode(mapData);
    if (mapJson != 'null') {
      return Column(
        children: [
          const Text(
            'FAI SCANNERIZZARE IL QRCODE AL PERSONALE!',
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          QrImageView(
            data: mapJson,
            version: QrVersions.auto,
            size: 250.0,
          )
        ],
      );
    } else {
      return const Text(
        'Non sono ancora presenti QRCodes. Visita un ristorante e vai sul carrello per effettuare un ordine!',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              generateQRCode(),
            ],
          ),
        ),
        appBar: const CustomAppBar(
          pageName: 'I tuoi codiciQR',
          backArrow: false,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped));
  }
}
