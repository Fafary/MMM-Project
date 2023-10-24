import 'package:flutter/material.dart';

import 'dir_fiche/fiche_screen.dart';
import 'home_screen.dart';
import 'authentification/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/fiches': (BuildContext context) => const MyHomePage(),
  '/fiche': (BuildContext context) => const FicheScreen(),
  '/': (BuildContext context) => const LoginScreenWidget(),
};