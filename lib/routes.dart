import 'package:flutter/material.dart';

import 'dir_campagne/campagne_screen.dart';
import 'dir_campagne/creation_campagne.dart';
import 'dir_campagne/list_campagne.dart';
import 'dir_fiche/creation_fiche.dart';
import 'dir_fiche/fiche_screen.dart';
import 'home_screen.dart';
import 'authentification/login_screen.dart';
import 'model/campagne_model.dart';
import 'model/fiche_model.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const MyHomePage(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/list_campaign': (BuildContext context) => const ListCampaignScreen(),
  '/campagne_screen': (BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Campagne;
    return CampaignScreen(campagne: args);
  },
  '/create_campaign': (BuildContext context) => const CampagneCreation(),
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
    return FicheScreen(campagne: args);
  }
};