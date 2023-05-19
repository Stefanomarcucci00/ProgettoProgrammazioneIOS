import 'package:firebase_database/firebase_database.dart';

class RestaurantModel {
  final String imageR;
  final String nomeR;
  final String descrizioneR;
  final String indirizzoR;
  final String orarioinizioR;
  final String orariofineR;
  final String telefonoR;
  final String tipoCiboR;
  final bool veganR;
  final int ratingR;
  final String idR;
  final String proprietarioR;

  RestaurantModel(
      {required this.imageR,
      required this.nomeR,
      required this.descrizioneR,
      required this.indirizzoR,
      required this.orarioinizioR,
      required this.orariofineR,
      required this.telefonoR,
      required this.tipoCiboR,
      required this.veganR,
      required this.ratingR,
      required this.idR,
      required this.proprietarioR});

  factory RestaurantModel.fromMap(Map<dynamic, dynamic> map) {
    return RestaurantModel(
        imageR: map['imageR'],
        nomeR: map['nomeR'],
        descrizioneR: map['descrizioneR'],
        indirizzoR: map['indirizzoR'],
        orarioinizioR: map['orarioinizioR'],
        orariofineR: map['orariofineR'],
        telefonoR: map['telefonoR'],
        tipoCiboR: map['tipoCiboR'],
        veganR: map['veganR'],
        ratingR: map['ratingR'],
        idR: map['idR'],
        proprietarioR: map['proprietarioR']);
  }
}