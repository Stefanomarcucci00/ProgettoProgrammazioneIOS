// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
// Questa classe descrive gli attributi e le relative tipologie di un utente

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

  // Converte una mappa in un UserModel
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
