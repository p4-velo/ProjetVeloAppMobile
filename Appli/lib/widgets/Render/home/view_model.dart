import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import '../../../POO/Incident.dart';
import '../../../POO/IncidentType.dart';
import '../../../POO/Localisation.dart';
import 'view.dart';


class Map extends StatefulWidget {
  const Map({super.key});

  @override
  MapState createState() {
    return MapState();
  }
}

class MapState extends State<Map> {
  bool isLoading = false;
  final PopupController _popupController = PopupController();
  late  List<Incident> incidents;
  late List<Marker> markers;
  late int pointIndex;
  List<LatLng> points = [
    const LatLng(47.322, 5.041),
    const LatLng(49.8566, 3.3522),
  ];

  late int nbSelectedIndices;



  void startLoading() async {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    incidents = generateRandomIncidents(30, );
    markers = filterIncidentsBySelectedTypes( incidents)
        .map<Marker>(
          (incident) => Marker(
        point: LatLng(incident.localisation.latitude, incident.localisation.longitude),
        child: Icon(
          incident.incidentType.icon,
          color: const Color(0XFF1A3972),
        ),
      ),
    )
        .toList();
    debugPrint('Markers: $markers');
    selectAll();
    _updateMarkers(_selectedIndices);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      popupcontroller: _popupController,
      markers: markers,
      points: points,
      incidentsTypes : _incidentTypes,
      selectedIndices : _selectedIndices,
      updateMarkers: _updateMarkers,

    );

    return currentView.render();
  }

  // Ajoutez cette fonction pour générer des coordonnées aléatoires autour de Dijon
  LatLng generateRandomCoordinates() {
    final random = Random();
    const dijonCenter = LatLng(47.322047, 5.041480);

    final lat = random.nextDouble() * 0.05 - 0.025 + dijonCenter.latitude;
    final lng = random.nextDouble() * 0.05 - 0.025 + dijonCenter.longitude;

    return LatLng(lat, lng);
  }

// Ajoutez cette fonction pour générer un type d'incident aléatoire
  IncidentType generateRandomIncidentType() {
    final random = Random();
    final incidentTypes = _incidentTypes;
    final index = random.nextInt(incidentTypes.length);

    return incidentTypes[index];
  }

// Ajoutez cette fonction pour générer une liste d'incidents aléatoires
  List<Incident> generateRandomIncidents(int count) {
    final random = Random();
    final incidents = <Incident>[];

    for (int i = 0; i < count; i++) {
      final id = random.nextInt(100000);
      final incidentType = generateRandomIncidentType();
      final location = Localisation(
        id: random.nextInt(100000),
        latitude: generateRandomCoordinates().latitude,
        longitude: generateRandomCoordinates().longitude,
      );
      final incident = Incident(id: id, incidentType: incidentType, localisation: location);

      incidents.add(incident);
    }
    return incidents;
  }

  List<Incident> filterIncidentsBySelectedTypes(  List<Incident> incidents) {
    final selectedIncidentTypes = getSelectedIncidentTypes();
    final filteredIncidents = <Incident>[];

    for (final incident in incidents) {
      if (selectedIncidentTypes.contains(incident.incidentType)) {
        filteredIncidents.add(incident);
      }
    }

    return filteredIncidents;
  }


  void _updateMarkers(List<int> selectedIndices) {
    List<Incident> selectedIncidents = [];
    debugPrint('Selected indices update horizontalButton: $selectedIndices');
    for (int i = 0; i < nbSelectedIndices; i++) {
      if (selectedIndices.contains(i)) {
        selectedIncidents.addAll(incidents.where((incident) => incident.incidentType == _incidentTypes[i]));
      }
    }
    debugPrint('Selected incidents update : $selectedIncidents');
    setState(() {
      markers = selectedIncidents.map<Marker>((incident) {
        return Marker(
          point: LatLng(incident.localisation.latitude, incident.localisation.longitude),
          child: Icon(
            incident.incidentType.icon,
            color: const Color(0XFF1A3972),
          ),
        );
      }).toList();
    });
  }



  final List<IncidentType> _incidentTypes = [
    IncidentType(name: 'Travaux', icon: Icons.construction),
    IncidentType(name: 'Incidents', icon: Icons.error_outline),
    IncidentType(name: 'Arceaux', icon: Icons.bike_scooter),
    IncidentType(name: 'DiviaPark', icon: Icons.local_parking),
  ];

  final List<int> _selectedIndices = [];


  List<IncidentType> getSelectedIncidentTypes() {
    return _selectedIndices.map((index) => _incidentTypes[index]).toList();
  }

  void selectAll() {
    setState(() {
      _selectedIndices.clear();
      for (int i = 0; i < _incidentTypes.length; i++) {
        _selectedIndices.add(i);
      }
      nbSelectedIndices = _selectedIndices.length;
    });
  }

  void deselectAll() {
    setState(() {
      _selectedIndices.clear();
    });
  }
}
