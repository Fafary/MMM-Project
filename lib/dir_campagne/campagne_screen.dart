import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/campagne_model.dart';
import '../model/database.dart';

class CampaignScreen extends StatefulWidget {
  final Campagne campagne;

  const CampaignScreen({Key? key, required this.campagne}) : super(key: key);

  @override
  CampaignScreenState createState() => CampaignScreenState();
}

class CampaignScreenState extends State<CampaignScreen> {
  List<Campagne> campagnes = [];

  final DatabaseServices databaseServices = DatabaseServices();

  Future<void> fetchCampagnes() async {
    final campagneList = await databaseServices.getCampagneList();
    setState(() {
      campagnes = campagneList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCampagnes();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE5F3E2), // Couleur de fond inspirée de la nature
        appBar: AppBar(
          backgroundColor: const Color(0xFF78AB46), // Couleur de la barre d'applications
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
            color: Colors.black,
            onPressed: () {
              log('IconButton pressed retour');
              Navigator.of(context).pushNamed('/list_campaign');
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF78AB46), // Couleur du conteneur du titre
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            widget.campagne.titre ?? "Titre",
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date de début',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              (widget.campagne.dateDebut as String?) ?? '01/01/2023',
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date de fin',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              (widget.campagne.dateFin as String?) ?? '01/31/2023',
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                    child: Text(
                      widget.campagne.description ?? 'Exemple de description',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      "Territoire",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                    child: Text(
                      widget.campagne.territoire ?? 'Bretagne',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      'Groupes Taxonomic',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                    child: Text(
                      widget.campagne.groupes ?? 'Champ de texte',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      'Fiches',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildCustomListItem('Oiseaux', context),
                        const SizedBox(height: 10),
                        buildCustomListItem('Mammifère', context),
                        const SizedBox(height: 10),
                        buildCustomListItem('Insectes', context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/create_fiche');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78AB46), // Couleur du bouton
                        elevation: 5,
                      ),
                      child: const Text(
                        'Créer une fiche',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.white, // Couleur du texte
                        ),
                      ),
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

Widget buildCustomListItem(String title, context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('/fiche_screen');
    },
    child: Material(
      color: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.file_copy_rounded,
                color: Colors.black,
                size: 36,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
