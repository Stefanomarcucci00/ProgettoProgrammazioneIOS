import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/User.dart';
import '../theme/widgets.dart';
import 'PageLogin.dart';

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

  Future<void> writeUserToDB(
      String nomeU,
      String cognomeU,
      String emailU,
      String pwdU,
      String telU,
      )async {
    //CREA NUOVO UTENTE E SALVA SU DB
    Map<String,String> newUser={
      'Cognome': cognomeU,
      'Email': emailU,
      'Livello': '1',
      'Nome': nomeU,
      'Passwrod': pwdU,
      'Telefono': telU,
      'Uri': 'Users-images/defaultuserimg',
    };
    try {
    FirebaseDatabase.instance.ref('Utenti').child(FirebaseAuth.instance.currentUser!.uid).set(newUser);
    }
    catch (error) {
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

  //FUNZIONE REGISTRA
  Future<void> registerUser(String email, String password,
      BuildContext context) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PageLogin()),
        );
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
            MyTextField(
                controller: nomeController,
                hintText: "nome",
                obscureText: false,
                enabled: true),
            const SizedBox(height: 10),
            MyTextField(
                controller: cognomeController,
                hintText: "cognome",
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
           /*
            MyTextField(
                controller: pwdConfirmController,
                hintText: "Conferma password",
                obscureText: true,
                enabled: true),
            const SizedBox(height: 10),

            */
            MyTextField(
                controller: telController,
                hintText: "num telefono",
                obscureText: false,
                enabled: true),
            const SizedBox(height: 20),
            RedButton(
              buttonText: 'Registrati',
              onPressed: () async {
                //FUNZIONE REGISTRATI
                registerUser(emailController.text, pwdController.text,
                     context);

                //SCRIVO UTENTE SUL DB
                writeUserToDB(
                    nomeController.text,
                    cognomeController.text,
                    emailController.text,
                    pwdController.text,
                    telController.text);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageLogin()),
                );
              },
            ),
            const SizedBox(height: 10),
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
