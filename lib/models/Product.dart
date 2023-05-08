class CartModel {
  final String nomeP;
  final String prezzoP;
  final String descrizioneP;
  final String idP;

  CartModel({
    required this.nomeP,
    required this.prezzoP,
    required this.descrizioneP,
    required this.idP,
  });

  factory CartModel.fromMap(Map<dynamic, dynamic> map) {
    return CartModel(
      nomeP: map['nomeP'],
      prezzoP: map['prezzoP'],
      descrizioneP: map['descrizioneP'],
      idP: map['idP'],
    );
  }
}
