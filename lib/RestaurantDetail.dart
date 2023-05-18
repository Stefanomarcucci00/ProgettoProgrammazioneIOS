import 'package:flutter/material.dart';

class RestaurantDetail extends StatefulWidget {

  final int index;

  const RestaurantDetail(this.index, {super.key});


  @override
  _RestaurantDetailState createState() => _RestaurantDetailState(index);
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final int index;

  _RestaurantDetailState(this.index);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Text(index.toString())
    );
  }

}
