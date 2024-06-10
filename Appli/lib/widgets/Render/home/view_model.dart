import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../POO/Incident.dart';
import '../../../POO/IncidentType.dart';
import '../../../POO/Localisation.dart';
import '../../../POO/Danger.dart';
import '../../../POO/DangerType.dart';
import 'view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skeletton_projet_velo/global.dart' as global;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  MapState createState() {
    return MapState();
  }
}

class MapState extends State<Home> {
  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController();
  late List<Incident> incidents;
  late List<Marker> markers;

  late List<Danger> dangers = [];

  late int pointIndex;
  List<LatLng> points = [
    const LatLng(47.322, 5.041),
    const LatLng(49.8566, 3.3522),
  ];
  List<String> addresses = [];
  bool shouldHideSize = true;
  late int nbSelectedIndices;

  List<LatLng> routePoints = [];
  Map<Permission, PermissionStatus> _permissionStatus = {};


  @override
  void dispose() {
    super.dispose();
  }

  bool isNavigating = false;

  @override
  void initState() {

    _getPermissionStatus();
    incidents = generateRandomIncidents(30);
    markers = filterIncidentsBySelectedTypes(incidents)
        .map<Marker>(
          (incident) => Marker(
        point: LatLng(incident.localisation.latitude, incident.localisation.longitude),
        child:  Icon(
          incident.incidentType.icon,
          color: global.primary,
        ),
      ),
    ).toList();
    selectAll();
    updateMarkerTag(_selectedIndices);
    super.initState();

    addCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      popupcontroller: _popupController,
      markers: markers,
      points: points,
      incidentsTypes: _incidentTypes,
      selectedIndices: _selectedIndices,
      updateMarkersTag: updateMarkerTag,
      searchAddresses: searchAddresses,
      getCoordinates: getCoordinates,
      formatAddress: formatAddress,
      addressesModel: addresses,
      mapController: _mapController,
      addMarker: addMarker,
      dangerTypes: _dangerTypes,
      addCustomMarkerCallback: addCustomMarker,
      fetchRoute: _fetchRoute,
      routePoints: routePoints,
      getCurrentLocation: _getCurrentLocation,
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

  List<Incident> filterIncidentsBySelectedTypes(List<Incident> incidents) {
    final selectedIncidentTypes = getSelectedIncidentTypes();
    final filteredIncidents = <Incident>[];

    for (final incident in incidents) {
      if (selectedIncidentTypes.contains(incident.incidentType)) {
        filteredIncidents.add(incident);
      }
    }

    return filteredIncidents;
  }



  void addMarker(LatLng point) {
    Marker marker = Marker(
      point: point,
      child: const Icon(
        Icons.location_on,
        color: Colors.red, // Choisissez la couleur que vous voulez
      ),
    );
    List<Marker> newMarkers =List.from(markers);
    newMarkers.add(marker);
    setState(() {
      markers = newMarkers;
    });
  }

  void updateMarkerTag(List<int> selectedIndices) {
    List<Incident> selectedIncidents = [];
    for (int i = 0; i < nbSelectedIndices; i++) {
      if (selectedIndices.contains(i)) {
        selectedIncidents.addAll(incidents.where((incident) => incident.incidentType == _incidentTypes[i]));
      }
    }
    List<Marker> listMarkers = selectedIncidents.map<Marker>((incident) {
      return Marker(
        point: LatLng(incident.localisation.latitude, incident.localisation.longitude),
        child : Icon(
          incident.incidentType.icon,
          color: global.primary,
        ),
      );
    }).toList();
    setState(() {
      markers = listMarkers;
    });
  }


  void addCustomMarker() {
    final random = Random();
    final LatLng coordinates = LatLng(47.3000, 5.1005);
    final Marker marker = Marker(
      point: coordinates,
      child: const Icon(
        Icons.engineering,
        color: Colors.red,
      ),
    );

    final Danger newDanger = Danger(
      id: dangers.length, // Par exemple, utilisez la longueur actuelle de la liste comme ID
      dangerType: DangerType(name: 'Custom Danger', icon: Icons.location_on), // Vous pouvez personnaliser ces détails
      localisation: Localisation(id: random.nextInt(100000), latitude: coordinates.latitude, longitude: coordinates.longitude),
    );

    setState(() {
      markers.add(marker);
      dangers.add(newDanger);
    });
    print("liste :");
    printDangersList();
  }

  void printDangersList() {
    for (var danger in dangers) {
      print('Danger ID: ${danger.id}, Type: ${danger.dangerType.name}, Coordinates: (${danger.localisation.latitude}, ${danger.localisation.longitude})');
    }
  }

  final List<IncidentType> _incidentTypes = [
    IncidentType(name: 'Travaux', icon: Icons.engineering),
    IncidentType(name: 'Incidents', icon: Icons.error_outline),
    IncidentType(name: 'Arceaux', icon: Icons.bike_scooter),
    IncidentType(name: 'DiviaPark', icon: Icons.local_parking),
  ];

  final List<DangerType> _dangerTypes = [
    DangerType(name: 'Travaux', icon: Icons.construction),
    DangerType(name: 'Accident', icon: Icons.car_crash),
    DangerType(name: 'Route inondée', icon: Icons.flood),
    DangerType(name: 'Danger', icon: Icons.report),
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

  Future<List<String>> searchAddresses(String query) async {
    final response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&countrycodes=fr&format=json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final List<String> places = data
          .where((entry) => entry['addresstype'] == 'place')
          .map<String>((e) => e['display_name'] as String)
          .where((address) => address.contains('21000'))
          .toList();
      return places;
    } else {
      throw Exception('Failed to search addresses');
    }
  }

  Future<Map<String, double>> getCoordinates(String address) async {
    final response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?format=json&q=$address'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> firstResult = data.first;
        final double lat = double.parse(firstResult['lat']);
        final double lon = double.parse(firstResult['lon']);
        return {'latitude': lat, 'longitude': lon};
      } else {
        throw Exception('No results found for the address');
      }
    } else {
      throw Exception('Failed to fetch coordinates');
    }
  }

  String formatAddress(String address) {
    List<String> parts = address.split(',');
    String formattedAddress = '${parts[0]}  ${parts[1]}, ${parts[3]}';

    return formattedAddress;
  }

  Future<void> _fetchRoute(LatLng startRoute, LatLng endRoute ) async {
    debugPrint('Fetching route from $startRoute to $endRoute');
    final String url = 'http://router.project-osrm.org/route/v1/bike/${startRoute.longitude},${startRoute.latitude};${endRoute.longitude},${endRoute.latitude}?geometries=geojson';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];
      setState(() {
        routePoints = coordinates.map((point) => LatLng(point[1], point[0])).toList();
        addMarker(endRoute);

        // _mapController.fitBounds(LatLngBounds.fromPoints([startRoute, endRoute]));   //zoom bon pour tout voir
        // _mapController.moveAndRotate(startRoute, 18.0,0.0);
        isNavigating = true;
        _startNavigation();
        //lancer la navigation
      });

    } else {
      print('Failed to load route');
    }
  }

  void _startNavigation() async {
    for (var point in routePoints) {
      if (!isNavigating) break;
      _mapController.move(point, 18.0);
      // await Future.delayed(Duration(seconds: 2));
    }
  }

  Future<String> _getUserCurrentAddress() async {
    // Récupérer la position actuelle de l'utilisateur
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Convertir la position en une adresse lisible
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];

    // Retourner l'adresse complète
    return '${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
  }



  Future<void> _getPermissionStatus() async {
    Map<Permission, PermissionStatus> permissionStatus = await [
      Permission.location,
    ].request();
    setState(() {
      _permissionStatus = permissionStatus;
    });
  }

  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    return currentPosition;
  }

}