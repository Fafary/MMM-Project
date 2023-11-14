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
  List<Campagne> campagnesAffichees = [];

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
    setState(() {
      textController.clear();
      campagnesAffichees.clear();
      campagnesAffichees.addAll(campagnes);
    });
  }

  final DatabaseServices databaseServices = DatabaseServices();

  Future<void> fetchCampagnes() async {
    final campagneList = await databaseServices.getCampagneList();
    setState(() {
      campagnes = campagneList;
      campagnesAffichees.addAll(campagnes);
    });
  }

  void searchCampagnes(String query) {
    setState(() {
      campagnesAffichees = campagnes
          .where((campagne) =>
      campagne.titre!.toLowerCase().contains(query.toLowerCase()) ||
          campagne.description!.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
        backgroundColor: const Color(0xFFE5F3E2),
        appBar: AppBar(
          backgroundColor: const Color(0xFF78AB46),
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // MODIFIER SI AJOUT D'UNE FONCTIONNALITEE PARAMETRE
                    },
                  ),
                  const Text(
                    'Biodivercity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
            ),
          ),
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
                          color: const Color(0xFF78AB46),
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
                                  onChanged: searchCampagnes, // Appel la fonction pour chercher une campagne
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    hintText: 'Chercher une campagne...',
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
                Padding(
                  // Affichage du titre campaign et du bouton create campaign
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Campagnes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF212121),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/create_campaign');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: const Color(0xFF78AB46),
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
                      for (var campagne in campagnesAffichees)
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
