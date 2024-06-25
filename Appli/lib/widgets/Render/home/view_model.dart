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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;





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
  List<Marker> markersClustered= [];
  List<Marker> nonClusteredMarkers = [];


  late List<Danger> dangers = [];
  late List<List<LatLng>> dangerOctagons = [];

  late int pointIndex;
  List<LatLng> points = [
    const LatLng(47.322, 5.041),
    const LatLng(49.8566, 3.3522),
  ];
  List<String> addresses = [];
  late int nbSelectedIndices;

  List<LatLng> routePoints = [];
  Map<Permission, PermissionStatus> _permissionStatus = {};

  bool internetLoading = true;
  bool isLoading = false;
  bool isLoadingPage = false;
  bool hasUserLocation = false;
  bool showAddress = true;
  bool showNoResult = false;
  bool? hasLocalisationPermission;

  final TextEditingController _controllerText = TextEditingController();




  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    _compassStreamSubscription.cancel();
    super.dispose();
  }

  bool isNavigating = false;

  @override
  void initState() {

    checkInternetConnection();
    _determinePosition();
    _startCompassAndLocalisationStream();

    incidents = generateRandomIncidents(0);

    markersClustered = filterIncidentsBySelectedTypes(incidents)
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
      markersClustered: markersClustered,
      nonClusteredMarkers: nonClusteredMarkers,
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
      navigation: _navigation,
      routePoints: routePoints,
      getCurrentLocation: _getCurrentLocation,
      permissionStatus: _permissionStatus,
      generateTest: generateTest,
      createDanger: createDanger,
      addMarkerTest: addMarkerTest,
      getDistance: getDistance,
      getIncidentCount: getIncidentCount,
      currentPosition: _currentPosition,
      currentHeading: _currentHeading,
      internetLoading: internetLoading,
      isLoading: isLoading,
      performSearch: performSearch,
      checkInternetConnection: checkInternetConnection,
      hasUserLocation: hasUserLocation,
      hasLocalisationPermission: hasLocalisationPermission,
      isLoadingPage: isLoadingPage,
      showAddress: showAddress,
      showNoResult: showNoResult,
      isNavigating: isNavigating,
      controllerText: _controllerText,

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
    List<Marker> newMarkers = [marker]; // clean la liste comme ça enlève l'ancien pin si il y avait , n'influe pas le point de l'user car se recréé tooujours .
    setState(() {
      nonClusteredMarkers = newMarkers;
    });
  }

  void updateMarkerUser(LatLng point, double heading, {bool withMoveCamera = false}) {
    double mapRotation = _mapController.camera.rotation;
    Marker newMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: point,
      rotate: false,
      child: Transform.rotate(
        angle: (heading ) * (pi / 180) - pi/4,
        child: const Icon(
          Icons.navigation,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );

    setState(() {
      if (_userMarker != null) {
        nonClusteredMarkers.remove(_userMarker);
      }
      nonClusteredMarkers.add(newMarker);
      _userMarker = newMarker;
      nonClusteredMarkers = List.from(nonClusteredMarkers);
      if (withMoveCamera) {
        _mapController.move(point, _mapController.camera.zoom);
        _mapController.rotate( -_currentHeading + 45);
      }

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
        List<Marker> newMarkers = List.from(markersClustered);
        newMarkers.add(marker);
        setState(() {
          markersClustered = newMarkers;
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
        List<Marker> newMarkers =List.from(markersClustered);
        newMarkers.add(marker);
        setState(() {
          markersClustered = newMarkers;
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
        List<Marker> newMarkers =List.from(markersClustered);
        newMarkers.add(marker);
        setState(() {
          markersClustered = newMarkers;
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
        List<Marker> newMarkers =List.from(markersClustered);
        newMarkers.add(marker);
        setState(() {
          markersClustered = newMarkers;
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
      markersClustered = listMarkers;
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

  Future<void> performSearch(String query) async {
    isLoading = true;
    try {
      final addressesFuntion = await searchAddresses(query);
      if (addresses.isNotEmpty) {
        showNoResult = false;
        addresses = addressesFuntion;
        debugPrint('Address found');
      } else {
        debugPrint('No addresses found');
        addresses = addressesFuntion;
        showNoResult = true;
      }
    } catch (error) {
      addresses = [];
      showNoResult = true;
      debugPrint('Error searching addresses: $error');
    } finally {
      isLoading = false;
    }
  }

  Future<List<String>> searchAddresses(String query, {bool useLoader = true,  bool showAddressOnHome = true}) async {
    if(useLoader) isLoading =true;
    if (showAddressOnHome) {
      setState(() {
        showAddress = true;
      });
    }
    final response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&countrycodes=fr&format=json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final List<String> places = data
          .where((entry) => entry['addresstype'] == 'place')
          .map<String>((e) => e['display_name'] as String)
          .where((address) => address.contains('21000'))
          .toList();
      debugPrint('Found ${places.length} places for query $query');

      if (places.isNotEmpty){
        showAddress = true;
      }else {
        addresses = [];
        showAddress = false;
      }
      return places;
    } else {
      addresses = [];
      throw Exception('Failed to search addresses');
    }
  }

  Future<Map<String, double>> getCoordinates(String address, {bool useLoader = true}) async {
    debugPrint('useLoader : $useLoader');
    if (useLoader) setState(() {isLoadingPage = true;});
    final response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?format=json&q=$address'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> firstResult = data.first;
        final double lat = double.parse(firstResult['lat']);
        final double lon = double.parse(firstResult['lon']);
        if (useLoader) setState(() {isLoadingPage = false;});
        setState(() {
          showAddress = false;
          showNoResult = false;
        });
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
        _mapController.fitBounds(LatLngBounds.fromPoints([startRoute, endRoute]));   //zoom bon pour tout voir
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

  void _navigation(bool navigation) async {
    setState(() {
      isNavigating = navigation;
    });
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
          if (hasUserLocation == false){
            setState(() {
              debugPrint('User location found');
              hasUserLocation = true;
            });
          }
          updateMarkerUser(_currentPosition!, _currentHeading);
          if (isNavigating){
            _updateMapPosition();
          }
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
          if (hasUserLocation == false){
            hasUserLocation = true;
          }
        }
      });
    });
    if (isNavigating){
      _updateMapPosition();
    }
  }

  void _updateMapPosition() {
    if (_currentPosition != null) {
      _mapController.move(_currentPosition!, 18.0);
      _mapController.rotate(-_currentHeading + 45);
    }
    //if (isNavigating){
    //_updateMapPosition();
    //}
  }


// Function to check if location services are enabled
  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        hasUserLocation = false;
      });
      throw Exception('Location services are disabled.');
    }
    return true;
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          hasLocalisationPermission = false;
          hasUserLocation = false;
        });
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        hasUserLocation = false;
        hasLocalisationPermission = false;
      });
      throw Exception('Location permissions are permanently denied.');
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      setState(() {
        hasLocalisationPermission = true;
      });
    }
  }

  Future<void> _determinePosition() async {
    try {
      await _checkLocationService();
      await _checkLocationPermission();

      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        hasUserLocation = true;
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error while determining position: $e');
    }
  }



  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    debugPrint(' conectivity result : ${connectivityResult.toString()}');

    if (connectivityResult.toString() == "ConnectivityResult.none") {
      setState(() {
        internetLoading = true;
      });
    } else {
      setState(() {
        internetLoading = false;
      });
    }
  }


}