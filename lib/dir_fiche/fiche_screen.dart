
import 'dart:developer';

import 'package:flutter/material.dart';

class FicheScreen extends StatefulWidget {
  const FicheScreen({Key? key}) : super(key: key);

  @override
  _FicheScreenWidgetState createState() => _FicheScreenWidgetState();
}

class _FicheScreenWidgetState extends State<FicheScreen> {

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
// Ajoutez autant de contrôleurs de texte que nécessaire

  FocusNode textFieldFocusNode1 = FocusNode();
  FocusNode textFieldFocusNode2 = FocusNode();
// Ajoutez autant de nœuds de focus que nécessaire


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    // Disposez des autres contrôleurs de texte
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
    // Disposez des autres nœuds de focus
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Form Details'),
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
