// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
// Questa classe descrive gli attributi e le relative tipologie di un prodotto all'interno di un menu
// Inoltre, descrive una lista di tipo Enum che corrisponde alle possibili tipologie dei prodotti

class ProductModel {
  final String nomeP;
  final String prezzoP;
  final String descrizioneP;
  final String idP;

  ProductModel({
    required this.nomeP,
    required this.prezzoP,
    required this.descrizioneP,
    required this.idP,
  });

  // Converte una mappa in un ProductModel
  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      nomeP: map['nomeP'],
      prezzoP: map['prezzoP'],
      descrizioneP: map['descrizioneP'],
      idP: map['idP'],
    );
  }
}

// Possibili tipologie di prodotti
enum FilterMenu { Bevande, Antipasti, Primi, Secondi, Contorni, Dolci }
