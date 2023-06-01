import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/CartProvider.dart';
import 'package:progetto_programmazione_ios/models/CartProduct.dart';
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

  _PageCarrelloState(this.user);

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

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    List<CartProductModel> cartProducts = cartProvider.cartProducts;

    void createQRCode() {

    }

    Widget cartExists() {
      if(cartProvider.cartProducts.isEmpty) {
        return const Center(
          child: Text(
            'Non sono ancora presenti prodotti nel tuo carrello. Seleziona un ristorante ed aggiungili!',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        );
      } else {
        return Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'RIEPILOGO ORDINE',
                style: TextStyle(
                    color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
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
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardCartProduct(
                        provider: cartProvider, product: cartProducts[index]);
                  },
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
              RedButton(buttonText: 'Genera QRCode', onPressed: createQRCode),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        pageName: 'Carrello',
        backArrow: false,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cartExists(),
          ],
        ),
      ),
    );
  }
}
