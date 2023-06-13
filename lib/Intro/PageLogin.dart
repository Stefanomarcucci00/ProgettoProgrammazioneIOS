import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progetto_programmazione_ios/PageRistoranti.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

import 'PageRegistrati.dart';

// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
/* Chi utilizza questa pagina può accedere all'interno dell'applicazione oppure navigare alla pagina Registrati */

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  // Questa funzione permette di effettuare il login quando i campi di email e password corrispondono
  // ad un account già creato
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      Fluttertoast.showToast(
          msg: "Login effettuato con successo.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PageRistoranti(
                  user: user,
                )),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "Utente non registrato.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Password errata.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pwdController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/Logo.png',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 20),
            MyTextField(
                controller: emailController,
                hintText: "E-mail",
                obscureText: false,
                enabled: true),
            const SizedBox(height: 10),
            MyTextField(
                controller: pwdController,
                hintText: "Password",
                obscureText: true,
                enabled: true),
            const SizedBox(height: 20),
            RedButton(
              buttonText: 'Entra',
              onPressed: () async {
                loginUser(emailController.text, pwdController.text, context);
              },
            ),
            const SizedBox(height: 20),
            // Cliccando sul bottone, la navigazione porterà alla pagina "Registrati"
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageRegister()),
                );
              },
              child: const Text('Non sei registrato? Clicca qui!',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
