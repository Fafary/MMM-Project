import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

import '../dir_campagne/campagne_screen.dart';
import '../model/campagne_model.dart';
import '../model/database.dart';
import '../model/fiche_model.dart';

class FicheScreen extends StatefulWidget {
  final Campagne campagne;

  const FicheScreen({Key? key, required this.campagne}) : super(key: key);

  @override
  FicheScreenWidgetState createState() => FicheScreenWidgetState();
}

class FicheScreenWidgetState extends State<FicheScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController afficheGPS = TextEditingController();
  FocusNode textFieldFocusNode1 = FocusNode();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController heureController = TextEditingController();
  TextEditingController dateHeureController = TextEditingController();
  FocusNode textFieldFocusNode2 = FocusNode();

  TextEditingController localisationController = TextEditingController();
  FocusNode textFieldFocusNode3 = FocusNode();

  TextEditingController observationController = TextEditingController();
  FocusNode textFieldFocusNode4 = FocusNode();

  final unfocusNode = FocusNode();

  final DatabaseServices databaseServices = DatabaseServices();

  @override
  void dispose() {
    super.dispose();
    afficheGPS.dispose();
    longitudeController.dispose();
    latitudeController.dispose();
    dateController.dispose();
    heureController.dispose();
    dateHeureController.dispose();
    localisationController.dispose();
    observationController.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
    textFieldFocusNode3.dispose();
    textFieldFocusNode4.dispose();
    unfocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF78AB46), // Couleur de la barre d'en-tête
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: afficheGPS,
                          focusNode: textFieldFocusNode1,
                          readOnly: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'gps',
                            hintText: 'Enter latitude',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.location_on),
                        color: Colors.black,
                        onPressed: () async {
                          // Récupère la position actuelle
                          Location location = Location();
                          // Vérifier que l'on a accès
                          bool serviceEnabled;
                          PermissionStatus permissionGranted;
                          LocationData currentLocation;

                          serviceEnabled = await location.serviceEnabled();
                          if (!serviceEnabled) {
                            serviceEnabled = await location.requestService();
                            if (!serviceEnabled) {
                              return;
                            }
                          }

                          permissionGranted = await location.hasPermission();
                          if (permissionGranted == PermissionStatus.denied) {
                            permissionGranted = await location.requestPermission();
                            if (permissionGranted != PermissionStatus.granted) {
                              return;
                            }
                          }

                          try {
                            currentLocation = await location.getLocation();
                            // Mettre à jour le contrôleur avec la latitude actuelle
                            afficheGPS.text = '${currentLocation.latitude}, ${currentLocation.longitude}';
                            longitudeController.text = '${currentLocation.longitude}';
                            latitudeController.text = '${currentLocation.latitude}';
                          } catch (e) {
                            log('Erreur lors de la récupération de la position : $e');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                DateTimePickerFormField(
                  dateController: dateController,
                  timeController: heureController,
                  dateTimeController: dateHeureController,
                  focusNode: textFieldFocusNode2,
                  labelText: 'Date et Heure',
                  hintText: 'Choisir une date et une heure',
                ),
                customTextFormField(
                  controller: localisationController,
                  focusNode: textFieldFocusNode3,
                  labelText: 'Localisation',
                  hintText: 'Définir une localisation',
                ),
                customTextFormField(
                  controller: observationController,
                  focusNode: textFieldFocusNode4,
                  labelText: 'Description',
                  hintText: 'Entrer une description',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Utiliser l'image_picker pour choisir une image depuis la galerie
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        // pickedFile.path sert à accéder au chemin de l'image sélectionnée
                        log('Image sélectionnée : ${pickedFile.path}');
                      } else {
                        log('Aucune image sélectionnée.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78AB46), // Couleur du bouton
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Ajouter une photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      final formData = {
                        'longitude': longitudeController.text,
                        'latitude': latitudeController.text,
                        'date': dateController.text,
                        'heure': heureController.text,
                        'localisation':localisationController.text,
                        'observation':observationController.text,
                      };

                      // Créer un objet Fiche à partir des valeurs du formulaire
                      final fiche = Fiche(
                        longitude: formData['longitude'],
                        latitude: formData['latitude'],
                        date: formData['date'],
                        heure: formData['heure'],
                        lieu: formData['localisation'],
                        observation: formData['observation'],
                      );

                      // Envoyer ou utiliser l'objet chantier en l'envoyant à Firebase
                      await databaseServices.updateFicheData(widget.campagne.titre!,fiche);

                      log('Button create campaign pressed');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CampaignScreen(campagne: widget.campagne),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78AB46), // Couleur du bouton
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Créer la fiche',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        color: Colors.white,
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

Widget customTextFormField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String labelText,
  required String hintText,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: const Color(0xFF78AB46), // Couleur du texte
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
    ),
  );
}

class DateTimePickerFormField extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController dateTimeController;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;

  DateTimePickerFormField({
    Key? key,
    required this.dateController,
    required this.timeController,
    required this.dateTimeController,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final DateFormat timeFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: dateTimeController,
            focusNode: focusNode,
            obscureText: false,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                // ignore: use_build_context_synchronously
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  DateTime pickedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  dateController.text = dateFormat.format(pickedDateTime);
                  timeController.text = timeFormat.format(pickedDateTime);
                  dateTimeController.text = format.format(pickedDateTime);
                }
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: const Color(0xFF78AB46), // Couleur du texte
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
