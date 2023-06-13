import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/models/User.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

import 'Intro/PageIntro.dart';
import 'PageRistoranti.dart';


// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
// Questa pagina permette all'utente di mostrare le proprie informazioni principali

class PageProfilo extends StatefulWidget {
  final User? user;

  const PageProfilo({super.key, required User? user}) : this.user = user;

  @override
  _PageProfiloState createState() => _PageProfiloState(user);
}

class _PageProfiloState extends State<PageProfilo> {
  final User? user;
  late Future<UserModel> usermodel;

  _PageProfiloState(this.user);

  @override
  void initState() {
    usermodel = getUser();
    super.initState();
  }

  // Richiama i dati dell'utente loggato
  Future<UserModel> getUser() async {
    final userDB = await FirebaseDatabase.instance
        .ref()
        .child('Utenti')
        .child('${user!.uid}')
        .get();
    final map = userDB.value as Map<dynamic, dynamic>;
    final usermodel = UserModel.fromMap(map);

    return usermodel;
  }

  int _selectedIndex = 0;

  // Navigazione della bottom navigation bar
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
        pageName: 'Profilo',
        backArrow: false,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash_2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // Dopo aver recuperato i dati, li posiziona all'interno della grafica
                child: FutureBuilder(
                  future: usermodel,
                  builder: (BuildContext context,
                      AsyncSnapshot<UserModel> snapshot) {
                    return Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: FutureBuilder(
                                    future: FirebaseStorage.instance
                                        .ref(snapshot.data!.Uri)
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
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(snapshot.data!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'BENVENUTO,',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data!.Nome +
                                        snapshot.data!.Cognome,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Nome',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        MyTextField(
                            hintText: snapshot.data!.Nome,
                            obscureText: false,
                            enabled: false),
                        const SizedBox(height: 10),
                        const Text(
                          'Cognome',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        MyTextField(
                            hintText: snapshot.data!.Cognome,
                            obscureText: false,
                            enabled: false),
                        const SizedBox(height: 10),
                        const Text(
                          'E-mail',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        MyTextField(
                            hintText: snapshot.data!.Email,
                            obscureText: false,
                            enabled: false),
                        const SizedBox(height: 10),
                        const Text(
                          'Telefono',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        MyTextField(
                            hintText: snapshot.data!.Telefono,
                            obscureText: false,
                            enabled: false),
                      ],
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
