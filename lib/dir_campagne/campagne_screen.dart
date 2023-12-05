import 'dart:developer';
import 'package:flutter/material.dart';
import '../dir_fiche/creation_fiche.dart';
import '../model/campagne_model.dart';
import '../model/database.dart';
import '../model/fiche_model.dart';
import '../model/user_model.dart';

class CampaignScreen extends StatefulWidget {
  final Campagne campagne;
  final UserDatabase user;

  const CampaignScreen({Key? key, required this.campagne, required this.user}) : super(key: key);

  @override
  CampaignScreenState createState() => CampaignScreenState();
}

class CampaignScreenState extends State<CampaignScreen> {
  List<Fiche> fiches = [];
  List<Fiche> userFiches = [];

  bool showAllFiches = true; //savoir si l'on veut afficher toutes les fiches

  final DatabaseServices databaseServices = DatabaseServices();

  Future<void> fetchFiches(String titre) async {
    final ficheList = await databaseServices.getFicheList(titre);
    final fetchUserFiches = ficheList.where((fiche) => fiche.nomCreateur == widget.user.nom).toList();
    setState(() {
      fiches = ficheList;
      userFiches = fetchUserFiches;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.campagne.titre != null) {
      fetchFiches(widget.campagne.titre!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? titre = widget.campagne.titre;
    titre!;
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE5F3E2),
        appBar: AppBar(
          backgroundColor: const Color(0xFF78AB46),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
            color: Colors.black,
            onPressed: () {
              log('IconButton pressed retour');
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Campagne',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
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
                        color: const Color(0xFF78AB46),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            titre,
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
                              widget.campagne.dateDebut ?? '01/01/2023',
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
                              widget.campagne.dateFin ?? '01/31/2023',
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
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FicheScreen(campagne: widget.campagne, user :widget.user),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78AB46),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Créer une fiche',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Affichage des fiches en fonction de l'option choisi (Toutes les fiches, fiches personnelles ou fiches abonnées)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
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
                        ],
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showAllFiches = true;
                            fetchFiches(widget.campagne.titre!);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: showAllFiches ? const Color(0xFF78AB46) : Colors.grey,
                        ),
                        child: const Text(
                          'Toutes les fiches',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showAllFiches = false;
                            fiches = userFiches;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !showAllFiches ? const Color(0xFF78AB46) : Colors.grey,
                        ),
                        child: const Text(
                          'Fiches Personnelles',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        for (var fiche in showAllFiches ? fiches : userFiches)
                          Column(
                            children: [
                              const SizedBox(height: 10), // Espace entre les fiches
                              buildCustomListItem(fiche, context),
                            ],
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

Widget buildCustomListItem(Fiche fiche, context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('/fiche_screen', arguments: fiche);
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
                fiche.observation ?? '',
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
