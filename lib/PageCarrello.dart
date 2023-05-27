import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';
import 'package:provider/provider.dart';

import 'Intro/PageIntro.dart';
import 'PageProfilo.dart';
import 'PageRistoranti.dart';

class PageCarrello extends StatefulWidget {
  final User? user;

  const PageCarrello({super.key, this.user});

  @override
  _PageCarrelloState createState() => _PageCarrelloState(user);
}

class _PageCarrelloState extends State<PageCarrello> {
  final User? user;

  var cartProductList;

  _PageCarrelloState(this.user);

  @override
  void initState() {
    //cartProductList = Provider.of<CartViewModel>(context, listen: false);
    cartProductList.getAllProducts();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          pageName: 'Carrello',
          backArrow: false,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
        );
  }
}
