import 'package:flutter/material.dart';

import 'dir_campagne/campagne_screen.dart';
import 'dir_campagne/creation_campagne.dart';
import 'dir_campagne/list_campagne.dart';
import 'dir_fiche/creation_fiche.dart';
import 'dir_fiche/fiche_screen.dart';
import 'authentification/login_screen.dart';
import 'model/campagne_model.dart';
import 'model/fiche_model.dart';
import 'model/user_model.dart';
import 'map.dart';

const argUser = null;

final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => const LoginScreen(),
  '/list_campaign': (BuildContext context) {
    final argUser = ModalRoute
        .of(context)!
        .settings
        .arguments as UserDatabase;
    return ListCampaignScreen(user: argUser);
  },
  '/campagne_screen': (BuildContext context) {
    final Map<String, dynamic> args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;

    final Campagne campagne = args['campagne'];
    final UserDatabase user = args['user'];

    return CampaignScreen(campagne: campagne, user: user);
  },
  '/create_campaign': (BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as UserDatabase;
    return CampagneCreation(user: args);
  },
  '/fiche_screen': (BuildContext context) {
    final Map<String, dynamic> args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;

    final Fiche fiche = args['fiche'];
    final UserDatabase user = args['user'];

    return FicheScreen(fiche: fiche, user: user);
  },
  '/create_fiche': (BuildContext context) {
    final Map<String, dynamic> args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;

    final Campagne campagne = args['campagne'];
    final UserDatabase user = args['user'];

    return CreationFiche(campagne: campagne, user: user);
  },
  '/map': (BuildContext context) {
    final Map<String, dynamic> args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;

    final Campagne campagne = args['campagne'];
    final UserDatabase user = args['user'];

    return MapScreen(campagne: campagne, user: user);
  },
};