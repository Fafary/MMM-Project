import 'package:flutter/material.dart';

import 'user_model.dart';
import 'database.dart';

class FonctionAppBar {
  final DatabaseServices databaseServices = DatabaseServices();

  void showSettingsMenu(BuildContext context, UserDatabase user) async {
    List<PopupMenuEntry<String>> menuItems = [];

    if (!user.isOrganisateur) {
      menuItems.add(
        const PopupMenuItem(
          value: 'option 1',
          child: Text('Passer administrateur'),
        ),
      );
    }

    menuItems.add(
      const PopupMenuItem(
        value: 'option 2',
        child: Text('Se déconnecter'),
      ),
    );

    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(110.0, 60.0, 0.0, 0.0),
      items: menuItems,
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        handleMenuItemSelection(context, value, user);
      }
    });
  }

  void handleMenuItemSelection(BuildContext context, String value, UserDatabase user) {
    switch (value) {
      case 'option 1':
        showUpgradeDialog(context, user);
        break;
      case 'option 2':
        Navigator.of(context).pushNamed('/login');
        break;
    }
  }

  void showUpgradeDialog(BuildContext context, UserDatabase user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Passer Organisateur"),
          content: ElevatedButton(
            onPressed: () {
              String mail = user.mail;
              databaseServices.upgradeUserToOrganisateur(mail);

              Navigator.of(context).pushNamed('/login');
            },
            child: const Text("Acheter pour 9.99 €"),
          ),
        );
      },
    );
  }

}