import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'campagne_model.dart';
import 'fiche_model.dart';

class DatabaseServices {
  static final doc = FirebaseFirestore.instance;

  final docRefCampagne = doc
      .collection("Campagne")
      .withConverter(
    fromFirestore: Campagne.fromFirestore,
    toFirestore: (Campagne campagne, options) => campagne.toFirestore(),
  );

  final docRefFiche = doc
      .collection("Fiche")
      .withConverter(
    fromFirestore: Fiche.fromFirestore,
    toFirestore: (Fiche fiche, options) => fiche.toFirestore(),
  );

  ///updates the data of the item of same titre as [campagne], if the titre doesn't
  ///exist in the database, the item is created.
  Future<void> updateCampagneData(Campagne campagne) async {
    try {
      await docRefCampagne.doc(campagne.titre).set(campagne);
    } catch (e) {
      log("Error updating campagne data: $e");
    }
  }

  ///updates the data of the item of same id as [demande], if the id doesn't
  ///exist in the database, the item is created.
  Future<void> updateFicheData(String titre, Fiche fiche) async {
    try {
      await docRefCampagne.doc(titre).collection('fiche').doc(fiche.id).set(fiche.toFirestore());
    } catch (e) {
      log("Error updating fiche data: $e");
    }
  }

  ///returns a list of items in "Campagne".
  Future<List<Campagne>> getCampagneList({int limit = 15}) async {
    try {
      final querySnapshot = await docRefCampagne.limit(limit).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log("Error fetching campagne list: $e");
      return [];
    }
  }

  ///returns a list of the items in "Fiche".
  Future<List<Fiche>> getFicheList({int limit = 15}) async {
    try {
      final querySnapshot = await docRefFiche.limit(limit).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log("Error fetching demande list: $e");
      return [];
    }
  }

  ///returns the amount of items in "Campagne".
  Future<int> campagneCount() async {
    final res = await docRefCampagne.count().get();
    return res.count;
  }

  ///returns the amount of items in "Fiche".
  Future<int> ficheCount() async {
    final res = await docRefFiche.count().get();
    return res.count;
  }

  ///returns wether the user of id [uid] is in the document stated in [document].
  Future<bool> getUserState(String uid, String document) async {
    final userSnapshot = await doc.collection(document).doc(uid).get();
    return userSnapshot.exists;
  }

  /// returns the string located in the field [dataField] of user of id [uid].
  /// Search if the user is a superuser
  Future<String> boolSuperUser(String uid, String dataField) async {
    if (await getUserState(uid, "superuser")){
      final userSnapshot = await doc.collection("User").doc(uid).get();
      return userSnapshot.get(dataField);
    }
    else {
      throw ("couldn't find user");
    }
  }

  ///removes [fiche] from "Fiche"
  Future<void> deleteFiche(Fiche fiche) async{
    try {
      await docRefFiche.doc(fiche.id).delete();
    } catch (e) {
      log("Error deleting fiche : $e");
    }
  }

  // Fonction pour récupérer les fiches de l'utilisateur
  Future<List<DocumentSnapshot>> getFichesPerso(String id) async {
    CollectionReference fichesCollection = FirebaseFirestore.instance.collection('Fiche');

    QuerySnapshot fiches = await fichesCollection.where(id).get();

    return fiches.docs;
  }
}