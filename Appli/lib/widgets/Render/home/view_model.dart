import 'dart:async';
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
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_compass/flutter_compass.dart';



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
  Marker? _userMarker;

  late StreamSubscription<Position> _positionStreamSubscription;
  late StreamSubscription<CompassEvent> _compassStreamSubscription;

  LatLng? _currentPosition;
  double _currentHeading = 0.0;


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

  bool isLoadingPage = false;



  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    _compassStreamSubscription.cancel();
    super.dispose();
  }

  bool isNavigating = false;

  @override
  void initState() {
    // isLoadingPage = true;

    _determinePosition();
    _startCompassAndLocalisationStream();

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
      routePoints: routePoints,
      getCurrentLocation: _getCurrentLocation,
      permissionStatus: _permissionStatus,
      generateTest: generateTest,
      createDanger: createDanger,
      addMarkerTest: addMarkerTest,
      currentPosition: _currentPosition,
      isLoadingPage: isLoadingPage,

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


  void updateMarkerUser(LatLng point, double heading, {bool withMoveCamera = false}) {
    double mapRotation = _mapController.camera.rotation;
    print('mapRotation: $mapRotation');
    Marker newMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: point,
      rotate: false,
      child: Transform.rotate(
        angle: (heading + mapRotation) * (3.1415926535897932 / 180),
        child: const Icon(
          Icons.navigation,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );

    setState(() {
      if (_userMarker != null) {
        markers.remove(_userMarker);
      }
      markers.add(newMarker);
      _userMarker = newMarker;
      markers = List.from(markers);
      if (withMoveCamera) {
        _mapController.move(point, _mapController.camera.zoom);
      }

    });
  }


  void addMarkerTest(LatLng point, String incidentName) {

    final random = Random();

    switch (incidentName) {
      case 'travaux':
        selectAll();
        updateMarkerTag(_selectedIndices);

        final incidentType = IncidentType(name: 'Travaux', icon: Icons.engineering);
        final location = Localisation(
          id: random.nextInt(100000),
          latitude: generateRandomCoordinates().latitude,
          longitude: generateRandomCoordinates().longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: const Icon(
            Icons.engineering,
          ),
        );
        List<Marker> newMarkers =List.from(markers);
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
          latitude: generateRandomCoordinates().latitude,
          longitude: generateRandomCoordinates().longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: const Icon(
            Icons.car_crash,
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
          latitude: generateRandomCoordinates().latitude,
          longitude: generateRandomCoordinates().longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: const Icon(
            Icons.flood,
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
          latitude: generateRandomCoordinates().latitude,
          longitude: generateRandomCoordinates().longitude,
        );
        final incident = Incident(id: incidents.length, incidentType: incidentType, localisation: location);
        incidents.add(incident);

        Marker marker = Marker(
          point: LatLng(location.latitude, location.longitude),
          child: const Icon(
            Icons.report,
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

        _mapController.fitBounds(LatLngBounds.fromPoints([startRoute, endRoute]));   //zoom bon pour tout voir
        isNavigating = true;
      });

    } else {
      print('Failed to load route');
    }
  }


  Future<String> _getUserCurrentAddress() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Convertir la position en une adresse lisible
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];

    // Retourner l'adresse complète
    return '${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
  }

  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    return currentPosition;
  }

  void _onCompassData(CompassEvent event) {
    if (event.heading != null) {
      setState(() {
        _currentHeading = event.heading!;
        if (_currentPosition != null){
          updateMarkerUser(_currentPosition!, _currentHeading);
        }
      });
    }
  }

  void _startCompassAndLocalisationStream() {
    _compassStreamSubscription = FlutterCompass.events!.listen(_onCompassData);
    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        if (_currentPosition != null){
          updateMarkerUser(_currentPosition!, _currentHeading);
        }      });
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }


}