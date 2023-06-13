import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/CartProvider.dart';
import 'package:progetto_programmazione_ios/Intro/PageIntro.dart';
import 'package:progetto_programmazione_ios/firebase_options.dart';
import 'package:provider/provider.dart';

// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
/* Questa classe inizializza l'applicazione, la connessione con Firebase
ed il CartProvider (per il carrello) */

// Inizializzazione dell'applicazione dopo la connessione con Firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'COOKADE',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Inizializzazione delle variabili Firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseapp = await Firebase.initializeApp();
    return firebaseapp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PageIntro();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}