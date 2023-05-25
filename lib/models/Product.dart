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

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      nomeP: map['nomeP'],
      prezzoP: map['prezzoP'],
      descrizioneP: map['descrizioneP'],
      idP: map['idP'],
    );
  }
}

enum FilterMenu { Bevande, Antipasti, Primi, Secondi, Contorni, Dolci }
