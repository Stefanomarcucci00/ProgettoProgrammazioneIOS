import 'package:flutter/material.dart';

class Search_bar extends StatelessWidget {
  const Search_bar({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(

      child:
      Container(
        //COPRE IL 20% DELLO SCHERMO
        height: size.height * 0.1,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "  Cerca",
                        hintStyle: TextStyle(color: Colors.red),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ),


    );
  }
}
