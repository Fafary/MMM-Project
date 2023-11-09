import 'package:flutter/material.dart';

import '../model/campagne_model.dart';
import '../model/database.dart';

class ListCampaignScreen extends StatefulWidget {
  const ListCampaignScreen({Key? key}) : super(key: key);

  @override
  ListCampaignScreenState createState() => ListCampaignScreenState();
}

class ListCampaignScreenState extends State<ListCampaignScreen> {
  List<Campagne> campagnes = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // Efface le texte du champ de texte.
  void clearText() {
    textController.clear();
  }

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
        if (textFieldFocusNode.hasPrimaryFocus) {
          FocusScope.of(context).requestFocus(textFieldFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: const Color(0xFFFF5722),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF757575),
                              size: 24,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                child: TextFormField(
                                  controller: textController,
                                  focusNode: textFieldFocusNode,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Chercher une campagne...',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF212121),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF212121),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: clearText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding( // Affichage du titre campaign et du bouton create campaign
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Campagnes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF212121),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/create_campaign');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.add, // Icône de croix
                          color: Colors.white, // Couleur de l'icône
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (var campagne in campagnes)
                        CampaignCard(
                          title: campagne.titre ?? "titre",
                          description: campagne.description ?? "description",
                          campagne: campagne,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}