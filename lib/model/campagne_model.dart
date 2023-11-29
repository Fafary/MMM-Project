import 'package:cloud_firestore/cloud_firestore.dart';

class Campagne {
  String? titre;
  String? dateDebut;
  String? dateFin;
  String? description;
  String? territoire;
  String? groupes;

  Campagne({
    this.titre,
    this.dateDebut,
    this.dateFin,
    this.description,
    this.territoire,
    this.groupes,
  });

  factory Campagne.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,){
    final data = snapshot.data();
    return Campagne(
      titre: data?['titre'],
      dateDebut: data?['dateDebut'],
      dateFin: data?['dateFin'],
      description: data?['description'],
      territoire: data?['territoire'],
      groupes: data?['groupes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titre != null) "titre": titre,
      if (dateDebut != null) "dateDebut": dateDebut,
      if (dateFin != null) "dateFin": dateFin,
      if (description != null) "description": description,
      if (territoire != null) "territoire": territoire,
      if (groupes != null) "groupes": groupes,
    };
  }

}
