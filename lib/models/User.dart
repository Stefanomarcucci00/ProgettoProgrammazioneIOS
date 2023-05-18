import 'package:firebase_database/firebase_database.dart';

class UserModel {
  final String Nome;
  final String Cognome;
  final String Email;
  final String Password;
  final String Telefono;
  final String Uri;
  final String Livello;

  UserModel({
    required this.Nome,
    required this.Cognome,
    required this.Email,
    required this.Password,
    required this.Telefono,
    required this.Uri,
    required this.Livello,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      Nome: map['Nome'],
      Cognome: map['Cognome'],
      Email: map['Email'],
      Password: map['Password'],
      Telefono: map['Telefono'],
      Uri: map['Uri'],
      Livello: map['Livello'],
    );
  }

}
