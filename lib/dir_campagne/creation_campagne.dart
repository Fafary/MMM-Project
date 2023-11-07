import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CampagneCreation extends StatefulWidget {
  const CampagneCreation({Key? key}) : super(key: key);

  @override
  CampagneCreationState createState() => CampagneCreationState();
}

class CampagneCreationState extends State<CampagneCreation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final textController1 = TextEditingController();
  final textFieldFocusNode1 = FocusNode();
  final textController2 = TextEditingController();
  final textFieldFocusNode2 = FocusNode();
  final textController3 = TextEditingController();
  final textFieldFocusNode3 = FocusNode();
  final textController4 = TextEditingController();
  final textFieldFocusNode4 = FocusNode();
  final unfocusNode = FocusNode();

  @override
  void dispose() {
    textController1.dispose();
    textFieldFocusNode1.dispose();
    textController2.dispose();
    textFieldFocusNode2.dispose();
    textController3.dispose();
    textFieldFocusNode3.dispose();
    textController4.dispose();
    textFieldFocusNode4.dispose();
    unfocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                        validator:FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                        controller: textController1,
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
                          controller: textController2,
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
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.44,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date de début',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.44,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date de fin',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: FormBuilderTextField(
                          name: 'nameTerritory',
                          validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                          controller: textController3,
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
                          controller: textController4,
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
                      onPressed: () {
                        Navigator.of(context).pushNamed('/list_campaign');
                        log('Button create campaign pressed');
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
