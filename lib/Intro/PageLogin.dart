import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

class PageLogin extends StatefulWidget {
  PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  void signUserIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
          title: Text('email errata'),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('password errata'),
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
            //SERVE PER OCCUPARE SPAZIO COME GAPFILLER
            const SizedBox(height: 50),
            //WELCOME
            Text(
              'Benvenuto su Coockade',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),
            //textfiel email
            MyTextField(
                controller: _emailController,
                hintText: 'email',
                obscureText: false),
            //textfiel pwd
            MyTextField(
                controller: _pwdController,
                hintText: 'password',
                obscureText: true),

            const SizedBox(height: 10),
            //pwd dimenticata?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(
                  'password dimenticata?',
                  style: TextStyle(color: Colors.red[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Btn(
              onTap: signUserIn,
            ),

            //NON REGISTRATO?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Non sei registrato?',
                    style: TextStyle(color: Colors.red[600]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Clicca qui',
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
