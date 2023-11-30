import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'campagne_model.dart';

class MapScreen extends StatelessWidget {
  final Campagne campagne;

  MapScreen({required this.campagne});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte de la campagne'),
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
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0), // Coordonnées du centre de la carte
                  zoom: 12.0, // Niveau de zoom initial
                ),
                markers: Set<Marker>.from([
                  Marker(
                    markerId: MarkerId('campagneMarker'),
                    position: LatLng(0, 0), // Coordonnées du marqueur sur la carte
                    infoWindow: InfoWindow(
                      title: 'Campagne Marker',
                    ),
                  ),
                ]),
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
