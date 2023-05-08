class RestaurantModel {
  final String imageR;
  final String nomeR;
  final String descrizioneR;
  final String indirizzoR;
  final String orarioinizioR;
  final String orariofineR;
  final String telefonoR;
  final String tipoCiboR;
  final veganR;
  final ratingR;
  final String idR;
  final String proprietarioR;

  RestaurantModel({
    required this.imageR,
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
    required this.proprietarioR
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json){
    return RestaurantModel(
        imageR : json['imageR'],
        nomeR : json['nomeR'],
        descrizioneR : json['descrizioneR'],
        indirizzoR : json['indirizzoR'],
        orarioinizioR : json['orarioinizioR'],
        orariofineR : json['orariofineR'],
        telefonoR : json['telefonoR'],
        tipoCiboR : json['tipoCiboR'],
        veganR : json['veganR'],
        ratingR : json['imageR'],
        idR : json['idR'],
        proprietarioR : json['proprietarioR']);
  }

}
