import 'package:flutter/material.dart';

import 'models/Restaurant.dart';

class RestaurantDetail extends StatefulWidget {

  final RestaurantModel restaurant;

  const RestaurantDetail(this.restaurant, {super.key});


  @override
  _RestaurantDetailState createState() => _RestaurantDetailState(restaurant);
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final RestaurantModel restaurant;

  _RestaurantDetailState(this.restaurant);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Text(restaurant.nomeR.toString())
    );
  }

}
