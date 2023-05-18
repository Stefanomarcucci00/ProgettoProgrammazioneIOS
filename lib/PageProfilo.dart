import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/models/User.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

import 'Intro/PageIntro.dart';
import 'PageRistoranti.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageRistoranti(user: user)));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PageProfilo(
                      user: user,
                    )));
        break;
      case 2:
        Navigator.push(context,
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          child: FutureBuilder(
            future: usermodel,
            builder:(BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              return Expanded(child: Column(
                children: [
                  MyTextField(hintText: snapshot.data!.Nome, obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(hintText: snapshot.data!.Cognome, obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(hintText: snapshot.data!.Email, obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(hintText: snapshot.data!.Telefono, obscureText: false),
                ],
              )
              );
            },
          ),
        )
      ],
      ),
    );
  }
}
