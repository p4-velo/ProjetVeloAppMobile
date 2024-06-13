import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
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
  List<Incident> incidents = [];
  List<Marker> markers= [];

  late List<Danger> dangers = [];
  late List<List<LatLng>> dangerOctagons = [];

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
    incidents = generateRandomIncidents(0);
    markers = filterIncidentsBySelectedTypes(incidents)
        .map<Marker>(
          (incident) => Marker(
        point: LatLng(incident.localisation.latitude, incident.localisation.longitude),
        child:  Icon(
          incident.incidentType.icon,
        ),
      ),
    ).toList();
    selectAll();
    updateMarkerTag(_selectedIndices);
    super.initState();
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
      fetchRoute: _fetchRoute,
      startNavigation: _startNavigation,
      routePoints: routePoints,

      // addIncidentMarker: addIncidentMarker,
      getCurrentLocation: _getCurrentLocation,
      permissionStatus: _permissionStatus,
      generateTest: generateTest,
      createDanger: createDanger,
      addMarkerTest: addMarkerTest,

      getDistance: getDistance,
      getIncidentCount: getIncidentCount,
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
  
  LatLng generateTest(){
    return generateRandomCoordinates();
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
    // final incidents = <Incident>[];
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

  void addMarkerTest(LatLng point, String incidentName) async {

    final random = Random();
    LatLng currentLocation = await _getCurrentLocation();

    switch (incidentName) {
      case 'travaux':
        selectAll();
        updateMarkerTag(_selectedIndices);

        final incidentType = IncidentType(name: 'Travaux', icon: Icons.engineering);
        final location = Localisation(
          id: random.nextInt(100000),
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: Icon(
            Icons.engineering,
            color: global.primary,
          ),
        );
        List<Marker> newMarkers = List.from(markers);
        newMarkers.add(marker);
        setState(() {
          markers = newMarkers;
        });
        break;

      case 'accident':
        selectAll();
        updateMarkerTag(_selectedIndices);

        final incidentType = IncidentType(name: 'Incidents', icon: Icons.car_crash);
        final location = Localisation(
          id: random.nextInt(100000),
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: Icon(
            Icons.car_crash,
            color: global.primary,
          ),
        );
        List<Marker> newMarkers =List.from(markers);
        newMarkers.add(marker);
        setState(() {
          markers = newMarkers;
        });
        break;

      case 'inondation':
        selectAll();
        updateMarkerTag(_selectedIndices);

        final incidentType = IncidentType(name: 'Incidents', icon: Icons.flood);
        final location = Localisation(
          id: random.nextInt(100000),
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: Icon(
            Icons.flood,
            color: global.primary,
          ),
        );
        List<Marker> newMarkers =List.from(markers);
        newMarkers.add(marker);
        setState(() {
          markers = newMarkers;
        });
        break;

      case 'danger':
        selectAll();
        updateMarkerTag(_selectedIndices);
        final incidentType = IncidentType(name: 'Incidents', icon: Icons.report);
        final location = Localisation(
          id: random.nextInt(100000),
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude, 
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: Icon(
            Icons.report,
            color: global.primary,
          ),
        );
        List<Marker> newMarkers =List.from(markers);
        newMarkers.add(marker);
        setState(() {
          markers = newMarkers;
        });
        break;

      default:
        break;
    }
  }

  Danger createDanger(String incidentType, LatLng location) {
    DangerType dangerType = DangerType(name: incidentType);
    Localisation localisation = Localisation(id: dangers.length, latitude: location.latitude, longitude: location.longitude);
    Danger danger = Danger(id: dangers.length + 1, dangerType: dangerType, localisation: localisation);
    dangers.add(danger);
    return danger;
  }

  void updateMarkerTag(List<int> selectedIndices) {
    List<Incident> selectedIncidents = [];
    for (int i = 0; i < nbSelectedIndices; i++) {
      if (selectedIndices.contains(i)) {
        selectedIncidents.addAll(incidents.where((incident) => incident.incidentType.name == _incidentTypes[i].name));
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

  final List<IncidentType> _incidentTypes = [
    IncidentType(name: 'Travaux', icon: Icons.engineering),
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

  int calculateIncidentsOnRoute(List<Incident> incidents, List<LatLng> routePoints) {
    double threshold = 0.001;
    int incidentCount = 0;
    Distance distance = Distance();

    for (var incident in incidents) {
      for (var point in routePoints) {
        double distanceInKm = distance.as(
          LengthUnit.Kilometer,
          LatLng(incident.localisation.latitude, incident.localisation.longitude),
          point,
        );
        // Si l'incident est à une distance inférieure au seuil, on le compte
        if (distanceInKm < threshold) {
          incidentCount++;
          break; // On peut arrêter de vérifier les autres points de l'itinéraire pour cet incident
        }
      }
    }
    return incidentCount;
  }

  List<LatLng> interpolatePoints(List<LatLng> routePoints, double distanceMeters) {
    final Distance distance = Distance();
    List<LatLng> interpolatedPoints = [];

    for (int i = 0; i < routePoints.length - 1; i++) {
      LatLng start = routePoints[i];
      LatLng end = routePoints[i + 1];

      interpolatedPoints.add(start);

      double segmentDistance = distance.as(
        LengthUnit.Meter,
        start,
        end,
      );
      int numberOfPoints = (segmentDistance / distanceMeters).floor();

      for (int j = 1; j <= numberOfPoints; j++) {
        double fraction = j / numberOfPoints;
        double lat = start.latitude + (end.latitude - start.latitude) * fraction;
        double lon = start.longitude + (end.longitude - start.longitude) * fraction;
        interpolatedPoints.add(LatLng(lat, lon));
      }
    }
    interpolatedPoints.add(routePoints.last);
    return interpolatedPoints;
  }

  String formatAddress(String address) {
    List<String> parts = address.split(',');
    String formattedAddress = '${parts[0]}  ${parts[1]}, ${parts[3]}';

    return formattedAddress;
  }

  double _routeDistance = 0.0;
  int _incidentCount = 0;

  Future<void> _fetchRoute(LatLng startRoute, LatLng endRoute ) async {
    debugPrint('Fetching route from $startRoute to $endRoute');
    final String url = 'http://router.project-osrm.org/route/v1/bike/${startRoute.longitude},${startRoute.latitude};${endRoute.longitude},${endRoute.latitude}?geometries=geojson';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];
      
      final double distance = data['routes'][0]['distance']/1000;
      
      setState(() {
        routePoints = coordinates.map((point) => LatLng(point[1], point[0])).toList();
        List<LatLng> interpolatedRoutePoints = interpolatePoints(routePoints, 50.0);
        int incidentCount = calculateIncidentsOnRoute(incidents, interpolatedRoutePoints);

        _routeDistance = distance;
        _incidentCount = incidentCount;

        addMarker(endRoute);
        isNavigating = true;
        _startNavigation();
      });

    } else {
      print('Failed to load route');
    }
  }

  double getDistance(){
    return _routeDistance;
  }

  int getIncidentCount(){
    return _incidentCount;
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