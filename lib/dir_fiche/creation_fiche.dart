import 'dart:developer';

import 'package:flutter/material.dart';

class FicheScreen extends StatefulWidget {
  const FicheScreen({Key? key}) : super(key: key);

  @override
  FicheScreenWidgetState createState() => FicheScreenWidgetState();
}

class FicheScreenWidgetState extends State<FicheScreen> {

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  FocusNode textFieldFocusNode1 = FocusNode();
  FocusNode textFieldFocusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();

    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Création d'une fiche"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: textController1,
              focusNode: textFieldFocusNode1,
              decoration: const InputDecoration(
                labelText: 'Entity File',
                hintText: 'Enter entity identification',
              ),
            ),
            TextFormField(
              controller: textController2,
              focusNode: textFieldFocusNode2,
              decoration: const InputDecoration(
                labelText: 'GPS Coordinate',
                hintText: 'Enter GPS coordinate',
              ),
            ),
            // Ajoutez d'autres champs de texte au besoin
            ElevatedButton(
              onPressed: () {
                // Gérez l'action du bouton ici
                log('Button pressed ...');
              },
              child: const Text('Add Photo'),
            ),
            ElevatedButton(
              onPressed: () {
                // Gérez l'action du bouton ici
                log('Button pressed ...');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
