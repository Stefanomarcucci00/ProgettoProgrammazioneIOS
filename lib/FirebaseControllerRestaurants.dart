import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:progetto_programmazione_ios/ChipController.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

class FirebaseControllerRist extends GetxController {
  var restaurantList = <RestaurantModel>[].obs;
  var restaurantListRating = <RestaurantModel>[].obs;
  late Future<List<RestaurantModel>> allRestaurants;

  final ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    restaurantListRating.bindStream(getRestaurantData(Filter.RATING));
    restaurantList.bindStream(
        getRestaurantData(Filter.values[_chipController.selectedChip]));
    super.onInit();
  }

  Stream<List<RestaurantModel>> getRestaurantData(Filter tipologia) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('Ristoranti');

    return dbRef.onValue.map((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>;

      switch (tipologia) {
        case Filter.ALL:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            restaurants.add(restaurant);
          });
          return restaurants;
        case Filter.RATING:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            if (restaurant.ratingR >= 3.5) {
              restaurants.add(restaurant);
            }
          });
          return restaurants;
        case Filter.VEGAN:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            if (restaurant.veganR) {
              restaurants.add(restaurant);
            }
          });
          return restaurants;
        case Filter.Pizza:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Pizza')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        case Filter.Burger:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Burger')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        case Filter.Italiano:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Italiano')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        case Filter.Cinese:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Cinese')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        case Filter.Giapponese:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Giapponese')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        case Filter.Indiano:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Indiano')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        case Filter.Greco:
          List<RestaurantModel> restaurants = [];
          map.forEach((key, value) {
            final restaurant = RestaurantModel.fromMap(value);
            List<String> substring = restaurant.tipoCiboR.split(',');
            for (String substring in substring) {
              if (substring.contains('Greco')) {
                restaurants.add(restaurant);
              }
            }
          });
          return restaurants;
        default:
          List<RestaurantModel> restaurants = [];
          return restaurants;
      }
    });
  }
}