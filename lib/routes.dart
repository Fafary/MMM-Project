import 'package:flutter/material.dart';

import 'dir_campagne/list_campagne.dart';
import 'dir_fiche/fiche_screen.dart';
import 'home_screen.dart';
import 'authentification/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const MyHomePage(),
  '/fiche': (BuildContext context) => const FicheScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/list_campaign': (BuildContext context) => const ListCampaignScreen(),
};