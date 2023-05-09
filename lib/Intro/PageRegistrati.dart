import 'package:flutter/material.dart';

class PageRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('Pagina di registrazione'),
        ),
      ),
    );
  }
}
