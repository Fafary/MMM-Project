import 'package:flutter/material.dart';

import '../model/campagne_model.dart';
import '../model/database.dart';
import '../model/user_model.dart';
import 'campagne_card.dart';

class ListCampaignScreen extends StatefulWidget {
  final UserDatabase user;
  const ListCampaignScreen({Key? key, required this.user}) : super(key: key);

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
                  const SizedBox(width: 50),
                  const Text(
                    'Biodivercity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSettingsMenu(context);
                    },
                  ),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
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
                                  onChanged: searchCampagnes,
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
                      Visibility(
                        visible: widget.user.isOrganisateur == true,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/create_campaign', arguments: widget.user);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: const Color(0xFF78AB46),
                            padding: const EdgeInsets.all(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
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
                          user: widget.user,
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

  void showSettingsMenu(BuildContext context) async {
    List<PopupMenuEntry<String>> menuItems = [];

    if (!widget.user.isOrganisateur) {
      menuItems.add(
        const PopupMenuItem(
          value: 'option 1',
          child: Text('Passer administrateur'),
        ),
      );
    }

    menuItems.add(
      const PopupMenuItem(
        value: 'option 2',
        child: Text('Devenir un Ours'),
      ),
    );

    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(110.0, 60.0, 0.0, 0.0),
      items: menuItems,
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        handleMenuItemSelection(value);
      }
    });
  }

  void handleMenuItemSelection(String value) {
    switch (value) {
      case 'option 1':
        showUpgradeDialog();
        break;
      case 'option 2':
        break;
    }
  }

  void showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Passer Organisateur"),
          content: ElevatedButton(
            onPressed: () {
              String mail = widget.user.mail;
              databaseServices.upgradeUserToOrganisateur(mail);

              Navigator.of(context).pop();
            },
            child: const Text("Acheter pour 9.99 €"),
          ),
        );
      },
    );
  }

}
