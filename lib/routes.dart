import 'package:flutter/material.dart';

import 'fiche_screen.dart';
import 'home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/fiches': (BuildContext context) => const MyHomePage(),
  '/': (BuildContext context) => const FicheScreen(),
};