import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../theme/widgets.dart';
import 'PageLogin.dart';
import 'PageRegistrati.dart';

class PageIntro extends StatelessWidget {
  const PageIntro({super.key});

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
        child: Center(
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
              const SizedBox(height: 50),
              RedButton(
                buttonText: 'Login',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageLogin()),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
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
      ),
    );
  }
}
