import 'dart:developer';

import 'package:flutter/material.dart';

import 'campaignCard.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (textFieldFocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(textFieldFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
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
                                    labelText: 'Search campaigns...',
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    'Campaigns',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF212121),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // AFFICHER LE CONTENU DE LA LISTE ICI
                      // Utilisation du widget CampaignCard pour les campagnes
                      CampaignCard(
                        title: 'Save the Bees',
                        description: 'Help protect bees and their habitats',
                      ),
                      CampaignCard(
                        title: 'Plant a Tree',
                        description: 'Contribute to reforestation efforts',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      log('Button pressed ...');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: Colors.green,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Campaign',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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