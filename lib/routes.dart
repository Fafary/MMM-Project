import 'package:flutter/material.dart';

import 'dir_campagne/campagne_screen.dart';
import 'dir_campagne/creation_campagne.dart';
import 'dir_campagne/list_campagne.dart';
import 'dir_fiche/creation_fiche.dart';
import 'dir_fiche/fiche_screen.dart';
import 'home_screen.dart';
import 'authentification/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const MyHomePage(),
  '/creation_fiche': (BuildContext context) => const FicheScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/list_campaign': (BuildContext context) => const ListCampaignScreen(),
  '/create_campaign': (BuildContext context) => const CampagneCreation(),
  '/campaign_screen': (BuildContext context) => const CampaignScreen(),
  '/fiche_screen': (BuildContext context) => const FicheWidget(),
};