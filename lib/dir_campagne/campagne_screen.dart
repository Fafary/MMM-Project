import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({Key? key}) : super(key: key);

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
            color: Colors.black,
            onPressed: () {
              print('IconButton pressed retour');
              Navigator.of(context).pushNamed('/list_campaign');
            },
          ),
          title: const Text(
            'Détails de la campagne',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
            ),
          ),
          actions: [],
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            'Titre de la campagne',
                            style: TextStyle(
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
                            // Exemple de texte A REMPLACER --------------------
                            Text(
                              '01/01/2023',
                              style: TextStyle(
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
                            Text(
                              'Date de fin',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Exemple de texte A REMPLACER --------------------
                            Text(
                              '01/31/2023',
                              style: TextStyle(
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
                      'Description de la campagne',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 4, 0, 0),
                    child: Text(
                      'Exemple de description',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      'Territoire',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 4, 0, 0),
                    child: Text(
                      'Bretagne',
                      style: TextStyle(
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
                      'Champ de texte',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 0, 0),
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
                        buildCustomListItem('Oiseaux'),
                        const SizedBox(height: 10),
                        buildCustomListItem('Mammifère'),
                        const SizedBox(height: 10),
                        buildCustomListItem('Insectes'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      'Commentaires',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                    // EXEMPLES A CHANGER PAR LES VALEURS DE LA BASE DE DONNEE
                    child: Text(
                      'Salut cette campagne est géniale',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
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

Widget buildCustomListItem(String title) {
  return InkWell(
    onTap: () {
      // Gére l'action lorsque l'élément est cliqué
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
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Icon(
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


