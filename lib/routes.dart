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
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Campagne;

    return CampaignScreen(campagne: args, user: argUser);
  },
  '/create_campaign': (BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as UserDatabase;
    return CampagneCreation(user: args);
  },
  '/fiche_screen': (BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Fiche;
    return FicheWidget(fiche: args);
  },
  '/create_fiche': (BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Campagne;
    return FicheScreen(campagne: args, user: argUser);
  }
};