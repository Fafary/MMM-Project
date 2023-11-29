import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';
import 'campagne_model.dart';
import 'fiche_model.dart';

class DatabaseServices {
  static final doc = FirebaseFirestore.instance;

  final docRefCampagne = doc.collection("Campagne").withConverter(
    fromFirestore: Campagne.fromFirestore,
    toFirestore: (Campagne campagne, options) => campagne.toFirestore(),
  );

  Future<UserDatabase> getUser(String mail) async {
    try {
      final snapshot = await doc.collection("User").doc(mail).get();

      // Check if the snapshot exists
      if (snapshot.exists) {
        return UserDatabase.fromFirestore(snapshot, null);
      } else {
        throw Exception("User not found for email: $mail");
      }
    } catch (e) {
      log("Error fetching user: $e");
      throw Exception("Error fetching user for email: $mail");
    }
  }

  void upgradeUserToOrganisateur(String docmail) async {
    try {
      DocumentReference userDoc = FirebaseFirestore.instance.collection('User')
          .doc(docmail);

      var docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        await userDoc.update({'isOrganisateur': true});
        log('User upgraded to Organisateur');
      } else {
        log('Document not found for mail: $docmail');
      }
    } catch (error) {
      log('Failed to upgrade user: $error');
    }
  }

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
      await docRefCampagne.doc(titre).collection('Fiche').doc(fiche.id).set(fiche.toFirestore());
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
  Future<List<Fiche>> getFicheList(String titre, {int limit = 15}) async {
    try {
      final querySnapshot = await docRefCampagne.doc(titre).collection('Fiche').limit(limit).get();
      return querySnapshot.docs.map((doc) => Fiche.fromFirestore(doc, null)).toList();
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
  Future<int> ficheCount(String titre) async {
    final res = await docRefCampagne.doc(titre).collection('Fiche').count().get();
    return res.count;
  }

  ///removes [fiche] from "Fiche"
  Future<void> deleteFiche(String titre, Fiche fiche) async{
    try {
      await docRefCampagne.doc(titre).collection('Fiche').doc(fiche.id).delete();
    } catch (e) {
      log("Error deleting fiche : $e");
    }
  }

  // Fonction pour récupérer les fiches de l'utilisateur
  Future<List<DocumentSnapshot>> getFichesPerso(String id) async {
    CollectionReference fichesCollection = FirebaseFirestore.instance.collection('Fiche');

    QuerySnapshot fiches = await fichesCollection.where('userId', isEqualTo: id).get();

    return fiches.docs;
  }

}