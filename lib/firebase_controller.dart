import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:progetto_programmazione_ios/ChipController.dart';
import 'package:progetto_programmazione_ios/models/Restaurant.dart';

class FirebaseController extends GetxController {
  var restaurantList = <RestaurantModel>[].obs;
  var RatingRestaurantList = <RestaurantModel>[].obs;
  late Future<List<RestaurantModel>> allRestaurants;

  final ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    RatingRestaurantList
        .bindStream(convertFutureToStream(getRestaurants(Filter.RATING)));
    allRestaurants = getRestaurants(Filter.ALL);
    restaurantList.bindStream(convertFutureToStream(
        getRestaurants(Filter.values[_chipController.selectedChip])));
    super.onInit();
  }

  Future<List<RestaurantModel>> getRestaurants(Filter tipologia) async {
    final List<RestaurantModel> restaurantList =
        []; // lista di ristoranti vuota
    final snapshot = await FirebaseDatabase.instance.ref('Ristoranti').get();
    final map = snapshot.value as Map<dynamic, dynamic>;

    switch (tipologia) {
      case Filter.ALL:
        map.forEach((key, value) {
          final restaurant = RestaurantModel.fromMap(value);
          restaurantList.add(restaurant);
        });
        return restaurantList;
      case Filter.RATING:
        map.forEach((key, value) {
          final restaurant = RestaurantModel.fromMap(value);
          if (restaurant.ratingR >= 3.5) {
            restaurantList.add(restaurant);
          }
        });
        return restaurantList;
      case Filter.VEGAN:
        map.forEach((key, value) {
          final restaurant = RestaurantModel.fromMap(value);
          if (restaurant.veganR) {
            restaurantList.add(restaurant);
          }
        });
        return restaurantList;
      default:
        map.forEach((key, value) {
          final restaurant = RestaurantModel.fromMap(value);
          if (restaurant.tipoCiboR
              .toLowerCase()
              .contains(tipologia.toString().toLowerCase())) {
            restaurantList.add(restaurant);
          }
        });
        return restaurantList;
    }
  }

  Stream<List<RestaurantModel>> convertFutureToStream(
      Future<List<RestaurantModel>> future) {
    late StreamController<List<RestaurantModel>> controller;
    Stream<List<RestaurantModel>> stream;

    void onData(List<RestaurantModel> data) {
      if (!controller.isClosed) {
        controller.add(data);
      }
    }

    void onError(Object error) {
      if (!controller.isClosed) {
        controller.addError(error);
      }
    }

    void onDone() {
      if (!controller.isClosed) {
        controller.close();
      }
    }

    controller = StreamController<List<RestaurantModel>>(
      onListen: () {
        future.then((data) {
          onData(data);
          onDone();
        }).catchError((error) {
          onError(error);
          onDone();
        });
      },
      onCancel: () => controller.close(),
    );

    stream = controller.stream;

    return stream;
  }
}
