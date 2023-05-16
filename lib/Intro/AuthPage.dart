import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/Intro/PageLogin.dart';
import 'package:progetto_programmazione_ios/PageRistoranti.dart';

import 'PageRegistrati.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //UTENTE LOGGATO
        if (snapshot.hasData) {
          return PageRistoranti();
        }
        //UTENTE NON LOGGATO
        else {
          return PageLogin();
        }
      },
    ));
  }
}
