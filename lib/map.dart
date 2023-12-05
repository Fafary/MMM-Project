import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/user_model.dart';
import 'model/campagne_model.dart';
import 'model/fonctions_appbar.dart';

class MapScreen extends StatelessWidget {
  final UserDatabase user;
  final Campagne campagne;

  final FonctionAppBar fctAppBar = FonctionAppBar();

  MapScreen({super.key, required this.user, required this.campagne});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF78AB46),
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Text(
                  'Biodivercity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    fctAppBar.showSettingsMenu(context, user);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Détails de la campagne : ${campagne.titre}'),
            SizedBox(
              width: 300, // Ajustez la largeur de la carte selon vos besoins
              height: 200, // Ajustez la hauteur de la carte selon vos besoins
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0), // Coordonnées du centre de la carte
                  zoom: 12.0, // Niveau de zoom initial
                ),
                markers: <Marker>{
                  const Marker(
                    markerId: MarkerId('campagneMarker'),
                    position: LatLng(0, 0), // Coordonnées du marqueur sur la carte
                    infoWindow: InfoWindow(
                      title: 'Campagne Marker',
                    ),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  // Vous pouvez ajouter des logiques supplémentaires ici
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
