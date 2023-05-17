import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/widgets.dart';

class PageRegister extends StatefulWidget {
  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {

  final _nomeController = TextEditingController();
  final _cognomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pwdConfirmController = TextEditingController();
  final _telController = TextEditingController();


  //FUNZIONE REGISTRA
  void register() async {
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
          email: _emailController.text, password: _pwdController.text);
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
          title: Text('formato email errato'),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('formato password errato'),
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
           MyTextField(controller: _emailController,hintText: "email", obscureText: false),
            SizedBox(height: 10),
            MyTextField(controller: _pwdController,hintText: "password", obscureText: true),
            SizedBox(height: 10),
            MyTextField(controller: _pwdConfirmController,hintText: "conferma password", obscureText: true),
            SizedBox(height: 20),
            Btn(
              onTap: register,
            ),
          ],
        ),
      ),
    );
  }
}
