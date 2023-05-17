import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const RedButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Text(buttonText),
    );
  }
}

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({Key? key,
    this.controller,
    required this.hintText,
    required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.red.shade400,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {

  final String pageName;
  final VoidCallback onPressed;

  const CustomAppBar({super.key, required this.pageName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(pageName),
      actions: <Widget>[

      ],
      backgroundColor: Colors.red,
    );
  }

}
