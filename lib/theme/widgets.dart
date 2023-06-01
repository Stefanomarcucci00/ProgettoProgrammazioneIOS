import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progetto_programmazione_ios/PageCarrello.dart';
import 'package:progetto_programmazione_ios/PageQR_Code.dart';
import 'package:progetto_programmazione_ios/models/CartProduct.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

import '../CartProvider.dart';
import '../models/Product.dart';

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
    return SizedBox(
      width: 500,
      child: Padding(
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  final ProductModel product;
  final CartProvider provider;
  final RestaurantModel restaurant;

  const CardProduct(
      {super.key,
      required this.product,
      required this.provider,
      required this.restaurant});

  @override
  Widget build(BuildContext context) {
    TextEditingController numberController = TextEditingController();

    void Function() addCartItemCallback(
        TextEditingController numberController,
        CartProvider provider,
        ProductModel product,
        RestaurantModel restaurant) {
      if (numberController.text != '0') {
        if (provider.cartProducts.isNotEmpty) {
          if (provider.cartProducts[0].restID == restaurant.idR) {
            return () {
              var tot = double.parse(numberController.text) *
                  double.parse(product.prezzoP);
              CartProductModel cartProduct = CartProductModel(
                  pName: product.nomeP,
                  pDesc: product.descrizioneP,
                  quantity: numberController.text,
                  totPrice: tot.toString(),
                  restID: restaurant.idR,
                  pID: product.idP);
              provider.addProduct(cartProduct);
            };
          } else {
            return () {
              Fluttertoast.showToast(
                  msg:
                      "Hai selezionato un prodotto da un ristorante diverso da quello iniziale.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            };
          }
        } else {
          return () {
            var tot = double.parse(numberController.text) *
                double.parse(product.prezzoP);
            CartProductModel cartProduct = CartProductModel(
                pName: product.nomeP,
                pDesc: product.descrizioneP,
                quantity: numberController.text,
                totPrice: tot.toString(),
                restID: restaurant.idR,
                pID: product.idP);
            provider.addProduct(cartProduct);
          };
        }
      } else {
        return () {
          Fluttertoast.showToast(
              msg: "Inserisci un numero diverso da 0.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        };
      }
    }

    void Function() onTapCallback =
        addCartItemCallback(numberController, provider, product, restaurant);

    return Center(
      child: SizedBox(
        width: 150,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: product.nomeP,
                        hintStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    product.descrizioneP,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: numberController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      background: Paint()
                        ..strokeWidth = 20.0
                        ..color = Colors.red
                        ..style = PaintingStyle.stroke
                        ..strokeJoin = StrokeJoin.round),
                  decoration: const InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.red,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: ElevatedButton(
                          onPressed: () => onTapCallback(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: const Text(
                            'AGGIUNGI',
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardCartProduct extends StatelessWidget {
  final CartProductModel product;
  final CartProvider provider;

  const CardCartProduct({super.key, required this.product, required this.provider});

  @override
  Widget build(BuildContext context) {
    TextEditingController numberController = TextEditingController();

    void removeProduct() {
      provider.removeProduct(product);
    }

    return Center(
      child: SizedBox(
        width: 150,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: product.pName,
                        hintStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    product.pDesc,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: numberController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      background: Paint()
                        ..strokeWidth = 20.0
                        ..color = Colors.red
                        ..style = PaintingStyle.stroke
                        ..strokeJoin = StrokeJoin.round),
                  decoration: InputDecoration(
                    hintText: product.quantity.toString(),
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.red,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: ElevatedButton(
                          onPressed: () => removeProduct(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: const Text(
                            'ELIMINA',
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
