import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mmm_project/dir_campagne/list_campagne.dart';

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

  String errorMessage = '';

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
              TextField(
                controller: nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
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
                    ).then((userCredential) {
                      // Store the user in the appropriate collection based on their role.
                      FirebaseFirestore.instance.collection('User').doc('$nom $prenom').set({
                        'Nom': nom,
                        'Prénom': prenom,
                        'e-mail': email,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListCampaignScreen(),
                        ),
                      );
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
