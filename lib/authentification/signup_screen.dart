import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../model/database.dart';
import '../model/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseServices databaseServices = DatabaseServices();
  late UserDatabase user;

  String errorMessage = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void subscribeToNotifications() {
    _firebaseMessaging.subscribeToTopic('allUsers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sign Up')),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFieldWidget(
                labelText: 'Nom',
                hintText: 'Entrez un nom',
                errorText: 'Ce champ est obligatoire',
                controller: nomController,
              ),
              CustomTextFieldWidget(
                labelText: 'Prénom',
                hintText: 'Entrez un prénom',
                errorText: 'Ce champ est obligatoire',
                controller: prenomController,
              ),
              CustomTextFieldWidget(
                labelText: 'E-mail',
                hintText: 'Entrez un e-mail',
                errorText: 'Ce champ est obligatoire',
                controller: emailController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: FormBuilderTextField(
                  name: 'Mot de passe',
                  validator: FormBuilderValidators.required(errorText: 'Ce champ est obligatoire'),
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: 'Entrez un mot de passe',
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String nom = nomController.text;
                    String prenom = prenomController.text;
                    String email = emailController.text;
                    String password = passwordController.text;

                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    ).then((userCredential) async {
                      await FirebaseFirestore.instance.collection('User').doc(email).set({
                        'Nom': nom,
                        'Prénom': prenom,
                        'e-mail': email,
                        'isOrganisateur': false
                      });

                      user = await databaseServices.getUser(email);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed('/list_campaign', arguments: user);
                    }).catchError((e) {
                      if (e is FirebaseAuthException) {
                        setState(() {
                          if (e.code == 'weak-password') {
                            errorMessage = 'Le mot de passe doit comporter au moins 6 caractères';
                          } else if (e.code == 'email-already-in-use') {
                            errorMessage = "L'adresse e-mail est déjà utilisée par un autre compte";
                          } else {
                            errorMessage = 'Une erreur s\'est produite lors de l\'inscription';
                          }
                        });
                      } else {
                        errorMessage = 'Une erreur s\'est produite lors de l\'inscription';
                      }
                    });
                  }
                },
                child: const Text('S\'inscrire'),
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextEditingController controller;

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.errorText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: FormBuilderTextField(
        name: labelText,
        validator: FormBuilderValidators.required(errorText: errorText),
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
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
    );
  }
}
