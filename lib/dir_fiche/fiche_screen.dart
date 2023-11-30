import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mmm_project/model/fiche_model.dart';

class FicheWidget extends StatefulWidget {
  const FicheWidget({Key? key, required Fiche fiche}) : super(key: key);

  @override
  FicheWidgetState createState() => FicheWidgetState();
}

class FicheWidgetState extends State<FicheWidget> {
  late TextEditingController textController;
  late FocusNode textFieldFocusNode;
  CarouselController? carouselController;
  int carouselCurrentIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (textFieldFocusNode.hasFocus) {
          FocusScope.of(context).requestFocus(textFieldFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFE5F3E2),
        appBar: AppBar(
          backgroundColor: const Color(0xFF78AB46), // Couleur de la barre d'en-tête
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5F3E2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fiche',
                          ),
                          Text(
                            'Date: 7/11/2023',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5F3E2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: TextFormField(
                        controller: textController,
                        focusNode: textFieldFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Observation',
                          hintText: 'Ajouter une observation',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF78AB46),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        minLines: 5,
                        maxLines: null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5F3E2),                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text(
                        'Name: Tree\n\nLocation:\nLatitude 12.12345°W\nLongitude 12.12347°N\n',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: CarouselSlider(
                    items: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://picsum.photos/seed/824/600',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://picsum.photos/seed/85/600',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://picsum.photos/seed/848/600',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://picsum.photos/seed/955/600',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    carouselController: carouselController,
                    options: CarouselOptions(
                      initialPage: 1,
                      viewportFraction: 0.5,
                      disableCenter: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      onPageChanged: (index, _) {
                        carouselCurrentIndex = index;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      log('Button pressed ...');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5F3E2),
                      padding: EdgeInsets.zero,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Submit'),
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
