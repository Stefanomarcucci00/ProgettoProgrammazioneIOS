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

  //FUNZIONE REGISTRA
  Future<void> registerUser(String email, String password, String pwdConfirm,
      BuildContext context) async {

    if(password==pwdConfirm) {
      try {
        final newUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        Fluttertoast.showToast(
            msg: "Registrato con successo.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

      writeUserToDB(nomeController.toString(),
                    cognomeController.toString(),
                    emailController.toString(),
                    pwdController.toString(),
                    telController.toString());


    }else{
      Fluttertoast.showToast(
          msg: "Errore durante la registrazione.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> writeUserToDB( String nomeU,
      String cognomeU,
      String emailU,
      String pwdU,
      String telU,
      )async {
    //CREA NUOVO UTENTE E SALVA SU DB
     var newUser=UserModel(Cognome: cognomeU,
                        Email: emailU,
                        Livello: '1',
                        Nome: nomeU,
                        Password: pwdU,
                        Telefono: telU,
                        Uri: "Users-images/defaultuserimg");
      FirebaseDatabase.instance.ref('Utenti').set(newUser);

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
            MyTextField(
                controller: pwdConfirmController,
                hintText: "Conferma password",
                obscureText: true,
                enabled: true),
            const SizedBox(height: 10),
            MyTextField(
                controller: telController,
                hintText: "num telefono",
                obscureText: true,
                enabled: true),
            const SizedBox(height: 20),
            RedButton(
              buttonText: 'Registrati',
              onPressed: () async {
                registerUser(emailController.text, pwdController.text,
                    pwdConfirmController.text, context);
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
