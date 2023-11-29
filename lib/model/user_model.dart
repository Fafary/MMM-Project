import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
  String? nom;
  String? prenom;
  String mail;
  bool isOrganisateur;

  UserDatabase({
    this.nom,
    this.prenom,
    required this.mail,
    required this.isOrganisateur
  });

  factory UserDatabase.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserDatabase(
      nom: data?['Nom'],
      prenom: data?['Prénom'],
      mail: data?['e-mail'],
      isOrganisateur: data?['isOrganisateur'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nom != null) "Nom": nom,
      if (prenom != null) "Prénom": prenom,
      "e-mail": mail,
      "isOrganisateur": isOrganisateur,
    };
  }

}