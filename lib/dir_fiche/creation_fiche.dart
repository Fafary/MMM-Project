
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class FicheScreen extends StatefulWidget {
  const FicheScreen({Key? key}) : super(key: key);

  @override
  FicheScreenWidgetState createState() => FicheScreenWidgetState();
}

class FicheScreenWidgetState extends State<FicheScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController textController1 = TextEditingController();
  FocusNode textFieldFocusNode1 = FocusNode();

  TextEditingController textController2 = TextEditingController();
  FocusNode textFieldFocusNode2 = FocusNode();

  TextEditingController textController3 = TextEditingController();
  FocusNode textFieldFocusNode3 = FocusNode();

  TextEditingController textController4 = TextEditingController();
  FocusNode textFieldFocusNode4 = FocusNode();

  final unfocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    textController1.dispose();
    textController2.dispose();
    textController4.dispose();
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textController1,
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
                        icon: Icon(Icons.location_on),
                        color: Colors.black,
                        onPressed: () async {
                          // Récupére la position actuelle
                          Location location = Location();
                          // Vérifier que l'on a accès
                          bool _serviceEnabled;
                          PermissionStatus _permissionGranted;
                          LocationData currentLocation;

                          _serviceEnabled = await location.serviceEnabled();
                          if (!_serviceEnabled) {
                            _serviceEnabled = await location.requestService();
                            if (!_serviceEnabled) {
                              return;
                            }
                          }

                          _permissionGranted = await location.hasPermission();
                          if (_permissionGranted == PermissionStatus.denied) {
                            _permissionGranted = await location.requestPermission();
                            if (_permissionGranted != PermissionStatus.granted) {
                              return;
                            }
                          }

                          try {
                            currentLocation = await location.getLocation();
                            // Mettre à jour le contrôleur avec la latitude actuelle
                            textController1.text = currentLocation.latitude.toString()+', '+currentLocation.longitude.toString();
                          } catch (e) {
                            print('Erreur lors de la récupération de la position : $e');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                DateTimePickerFormField(
                  controller: textController2,
                  focusNode: textFieldFocusNode2,
                  labelText: 'Date et Heure',
                  hintText: 'Choisir une date et une heure',
                ),
                customTextFormField(
                  controller: textController3,
                  focusNode: textFieldFocusNode3,
                  labelText: 'Localisation',
                  hintText: 'Définir une localisation',
                ),
                customTextFormField(
                  controller: textController4,
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
                        print('Image sélectionnée : ${pickedFile.path}');
                      } else {
                        print('Aucune image sélectionnée.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add Photo',
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
                    onPressed: () {
                      print('Button pressed to go on sheet list');
                      //Navigator.pushNamed(currentContext, '/list_campaign');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
            color: Colors.green,
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
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;

  DateTimePickerFormField({
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
  });

  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Column (
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
          SizedBox(height: 8),

          TextFormField(
            readOnly: true,
            controller: controller,
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

                  controller.text = format.format(pickedDateTime);
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
                  color: Colors.green,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: TextStyle(
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