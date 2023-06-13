import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../theme/widgets.dart';
import 'PageLogin.dart';

// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
/* Chi utilizza questo fragment può effettuare la registrazione compilando appositamente
  tutti i campi richiesti, oppure può navigare alla pagina Login */

class PageRegister extends StatefulWidget {
  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  final nomeController = TextEditingController();
  final cognomeController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final pwdConfirmController = TextEditingController();
  final telController = TextEditingController();

  // Quando tutti i campi sono compilati correttamente, verrà creata un'istanza
  // authentication e verranno salvati i dati dell'utente sul database
  Future<void> writeUserToDB(
    String nomeU,
    String cognomeU,
    String emailU,
    String pwdU,
    String telU,
  ) async {
    Map<String, String> newUser = {
      'Nome': nomeU,
      'Cognome': cognomeU,
      'Email': emailU,
      'Passwrod': pwdU,
      'Telefono': telU,
      'Uri': 'Users-images/defaultuserimg',
      'Livello': '1',
    };
    try {
      FirebaseDatabase.instance
          .ref('Utenti')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .set(newUser);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageLogin()),
      );
    } catch (error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> registerUser(
      String email, String password, BuildContext context) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "email gia in uso.",
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
            const Text('Compila tutti i campi per registrarti!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            MyTextField(
                controller: nomeController,
                hintText: "Nome",
                obscureText: false,
                enabled: true),
            const SizedBox(height: 10),
            MyTextField(
                controller: cognomeController,
                hintText: "Cognome",
                obscureText: false,
                enabled: true),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            MyTextField(
                controller: pwdConfirmController,
                hintText: "Conferma password",
                obscureText: true,
                enabled: true),
            const SizedBox(height: 10),
            MyTextField(
                controller: telController,
                hintText: "Telefono",
                obscureText: false,
                enabled: true),
            const SizedBox(height: 20),
            RedButton(
              buttonText: 'Registrati',
              onPressed: () async {
                if (
                    pwdController.text.isNotEmpty &&
                    pwdController.text.length > 5 &&
                    pwdController.text == pwdConfirmController.text &&

                    nomeController.text.length < 20 &&
                    nomeController.text.isNotEmpty &&

                    cognomeController.text.length < 20 &&
                    cognomeController.text.isNotEmpty &&

                    emailController.text.length < 40 &&
                    emailController.text.isNotEmpty &&

                    telController.text.length > 9 &&
                    telController.text.isNotEmpty) {

                  registerUser(
                      emailController.text, pwdController.text,context);

                  writeUserToDB(
                      nomeController.text.toString(),
                      cognomeController.text.toString(),
                      emailController.text.toString(),
                      pwdController.text.toString(),
                      telController.text.toString() );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PageLogin()),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Controlla che tutti i campi siano corretti.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            const SizedBox(height: 10),
            // Cliccando sul bottone, la navigazione porterà alla pagina "login"
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageLogin()),
                );
              },
              child: const Text(
                  'Già registrato? Clicca qui per effettuare il login!',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
