import 'package:cloud_firestore/cloud_firestore.dart';

class Fiche {
  String? id;
  String? latitude;
  String? longitude;
  DateTime? date;
  DateTime? heure;
  String? lieu;
  String? photos;
  String? observation;

  Fiche({
    this.id,
    this.latitude,
    this.longitude,
    this.date,
    this.heure,
    this.lieu,
    this.photos,
    this.observation
  });

  factory Fiche.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,){
    final data = snapshot.data();
    return Fiche(
      id: data?['id'],
      latitude: data?['latitude'],
      longitude: data?['longitude'],
      date: data?['date'],
      heure: data?['heure'],
      lieu: data?['lieu'],
      photos: data?['photos'],
      observation: data?['observation']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
      if (date != null) "date": date,
      if (heure != null) "heure": heure,
      if (lieu != null) "lieu": lieu,
      if (photos != null) "photos": photos,
      if (observation != null) "observation": observation
    };
  }

}