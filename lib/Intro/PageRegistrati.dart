import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    //loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //tentativo signin
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: pwdController.text);
      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //email errata
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      }
      //pop loading circle
      Navigator.pop(context);
      //password errata
      if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Formato email errato'),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Formato password errato'),
        );
      },
    );
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
              child: const Text('Già registrato? Clicca qui per effettuare il login!',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
