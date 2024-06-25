
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';


import '../../../POO/IncidentType.dart';

class MobileView {
  BuildContext context;
  bool isLoading;
  PopupController popupcontroller;
  List<Marker> markers;
  List<LatLng> points;
  List<IncidentType> incidentsTypes;
  List<int> selectedIndices;
  Function updateMarkers;



  MobileView({
    required this.context,
    required this.isLoading,
    required this.popupcontroller,
    required this.markers,
    required this.points,
    required this.incidentsTypes,
    required this.selectedIndices,
    required this.updateMarkers,
  });


  final TextStyle selectedTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final TextStyle unselectedTextStyle = const TextStyle(
    color: Color(0XFF102a5b),
    fontWeight: FontWeight.bold,
  );


  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          floatingActionButton: Transform.scale(
            scale: 1.3,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // Changez ce rayon selon vos besoins
              ),
              child: const Icon(Icons.warning, color: Color(0XFF1A3972), size: 35,),
              onPressed: () {
                //to do
              },
            ),
          ),
          body: Stack(
            children: [
              PopupScope(
                popupController: popupcontroller,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: points[0],
                    initialZoom: 14,
                    maxZoom: 20,
                    onTap: (_, __) => popupcontroller.hideAllPopups(), // Hide popup when the map is tapped.
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        spiderfyCircleRadius: 80,
                        spiderfySpiralDistanceMultiplier: 2,
                        circleSpiralSwitchover: 12,
                        maxClusterRadius: 120,
                        rotate: true,
                        size: const Size(40, 40),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(50),
                        maxZoom: 15,
                        markers: markers,
                        popupOptions: PopupOptions(
                            popupSnap: PopupSnap.markerTop,
                            popupController: popupcontroller,
                            popupBuilder: (_, marker) => Container(
                              width: 200,
                              height: 100,
                              color: Colors.white,
                              child: GestureDetector(
                                onTap: () => debugPrint('Popup tap!'),
                                child: const Text(
                                  'Le nom du POI',
                                ),
                              ),
                            )),
                        builder: (context, markers) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0XFF1A3972),
                            ),
                            child: Center(
                              child: Text(
                                markers.length.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  // La barre de recherche est le premier enfant de la colonne
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Fond blanc
                        borderRadius: BorderRadius.circular(30), // Bord arrondi
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15, left: 4.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color(0XFF1A3972),
                              borderRadius: BorderRadius.circular(30), // Bord arrondi
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Rechercher un lieu ',
                                hintStyle: TextStyle(
                                  color: Colors.grey, // Texte gris
                                ),
                                border: InputBorder.none, // Pas de bordure
                              ),
                              onChanged: (value) {
                                // Traitez la saisie de l'utilisateur ici
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: incidentsTypes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final incidentType = incidentsTypes[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                  if (selectedIndices.contains(index)) {
                                    selectedIndices.remove(index);
                                  } else {
                                    selectedIndices.add(index);
                                  }
                                  updateMarkers(selectedIndices);
                                },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIndices.contains(index) ? const Color(0XFF102a5b) : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      incidentType.icon,
                                      color: selectedIndices.contains(index) ? Colors.white : const Color(0XFF102a5b),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      incidentType.name,
                                      style: selectedIndices.contains(index) ? selectedTextStyle : unselectedTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}