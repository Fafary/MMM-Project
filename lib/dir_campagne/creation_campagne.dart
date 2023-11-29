import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../model/user_model.dart';
import '../model/campagne_model.dart';
import '../model/database.dart';

import 'package:intl/intl.dart';

class CampagneCreation extends StatefulWidget {
  final UserDatabase user;
  const CampagneCreation({Key? key, required this.user}) : super(key: key);

  @override
  CampagneCreationState createState() => CampagneCreationState();
}

class CampagneCreationState extends State<CampagneCreation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final textFieldFocusNode1 = FocusNode();
  final descriptionController = TextEditingController();
  final textFieldFocusNode2 = FocusNode();
  final territoireController = TextEditingController();
  final textFieldFocusNode3 = FocusNode();
  final groupesController = TextEditingController();
  final textFieldFocusNode4 = FocusNode();
  final unfocusNode = FocusNode();

  final DatabaseServices databaseServices = DatabaseServices();

  DateTime dateDebutController = DateTime.now();
  DateTime dateFinController = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    titleController.dispose();
    textFieldFocusNode1.dispose();
    descriptionController.dispose();
    textFieldFocusNode2.dispose();
    territoireController.dispose();
    textFieldFocusNode3.dispose();
    groupesController.dispose();
    textFieldFocusNode4.dispose();
    unfocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFF78AB46), // Couleur de la barre d'en haut
          title: const Text('Créer une campagne'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                      controller: titleController,
                      focusNode: textFieldFocusNode1,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Titre',
                        hintText: 'Enter campaign title',
                        hintStyle: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightGreen,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: FormBuilderTextField(
                        name: 'description',
                        validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                        controller: descriptionController,
                        focusNode: textFieldFocusNode2,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Entrer une description...',
                          hintStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.lightGreen,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Column(
                        children: [

                          const Text('Début de la campagne'),
                          BasicDateField(
                            onDateChanged: (selectedDate) {
                              setState(() {
                                dateDebutController = selectedDate ?? DateTime.now();
                              });
                            },
                            customFirstDate: DateTime.now(),
                          ),
                          const SizedBox(height: 16), // Adjust the spacing as needed
                          const Text('Fin de la campagne'),
                          BasicDateField(
                            onDateChanged: (selectedDate) {
                              setState(() {
                                dateFinController = selectedDate ?? DateTime.now();
                              });
                            },
                            customFirstDate: dateDebutController.add(const Duration(days: 1)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: FormBuilderTextField(
                        name: 'nameTerritory',
                        validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                        controller: territoireController,
                        focusNode: textFieldFocusNode3,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Territoire',
                          hintText: 'Entrer un territoire (commune ou liste de communes)',
                          hintStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.lightGreen,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: FormBuilderTextField(
                        name: 'groupName',
                        controller: groupesController,
                        focusNode: textFieldFocusNode4,
                        validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                        decoration: InputDecoration(
                          labelText: ' Groupes Taxonomic',
                          hintText: 'Entrer des groupes taxonomic à identifier',
                          hintStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.lightGreen,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentContext = context;

                      final formData = {
                        'titre': titleController.text,
                        'dateDebut': dateDebutController.toLocal().toString(),
                        'dateFin': dateFinController.toLocal().toString(),
                        'description': descriptionController.text,
                        'territoire': territoireController.text,
                        'groupes': groupesController.text,
                      };

                      // Créer un objet Campagne à partir des valeurs du formulaire
                      final campagne = Campagne(
                        titre: formData['titre'],
                        dateDebut: formData['dateDebut'],
                        dateFin: formData['dateFin'],
                        description: formData['description'],
                        territoire: formData['territoire'],
                        groupes: formData['groupes'],
                      );

                      // Envoyer ou utiliser l'objet campagne en l'envoyant à Firebase
                      await databaseServices.updateCampagneData(campagne);

                      log('Button create campaign pressed');

                      // ignore: use_build_context_synchronously
                      Navigator.of(currentContext).pushNamed('/create_fiche', arguments: widget.user);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      alignment: Alignment.center,
                      child: const Text(
                        'Créer une campagne',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
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

class BasicDateField extends StatelessWidget {
  final DateFormat format = DateFormat("yyyy-MM-dd");
  final void Function(DateTime?) onDateChanged;
  final DateTime customFirstDate;

  BasicDateField({
    Key? key,
    required this.onDateChanged,
    required this.customFirstDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              firstDate: customFirstDate,
              initialDate: currentValue ?? customFirstDate,
              lastDate: DateTime(2100),
            );
          },
          onChanged: onDateChanged,
        ),
      ],
    );
  }
}

