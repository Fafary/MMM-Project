import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dir_campagne/campagne_screen.dart';

class CampaignCard extends StatefulWidget {
  final String title;
  final String description;
  final Campagne campagne;

  const CampaignCard({Key? key, required this.title, required this.description, required this.campagne})
      : super(key: key);

  @override
  CampaignCardState createState() => CampaignCardState();
}

class CampaignCardState extends State<CampaignCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CampaignScreen(campagne: widget.campagne),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered ? Colors.green : Colors.grey, // Couleur de l'ombre en vert lors du survol
                  offset: const Offset(2, 2), // Décalage vers le bas et vers la droite
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0x4D9489F5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.nature_people_rounded,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xFF212121),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.description,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Campagne {
  String? titre;
  DateTime? dateDebut;
  DateTime? dateFin;
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


