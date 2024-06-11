// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletton_projet_velo/global.dart' as global;
import 'package:skeletton_projet_velo/widgets/CustomWidget/CustomLoader/view_model.dart';
import '../../../POO/IncidentType.dart';
import '../../../POO/DangerType.dart';
import 'view_model.dart';
import 'dart:math';

class MobileView {
  BuildContext context;
  bool isLoading;
  PopupController popupcontroller;
  List<Marker> markers;
  List<LatLng> points;
  List<IncidentType> incidentsTypes;
  List<int> selectedIndices;
  Function updateMarkers;
  Function updateMarkersTag;
  Function searchAddresses;
  Function getCoordinates;
  Function formatAddress;
  Function stopLoading;
  Function setAddresses;
  List<String> addressesModel;
  bool shouldHideSize;
  Function setShouldHideSize;
  bool isLoadingPage;
  MapController mapController;
  Function addMarker;
  Function fetchRoute;
  List<LatLng> routePoints;
  Function getUserCurrentAddress;
  Function createDanger;
  Function addMarkerTest;
  Function generateTest;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.popupcontroller,
    required this.markers,
    required this.points,
    required this.incidentsTypes,
    required this.selectedIndices,
    required this.updateMarkers,
    required this.updateMarkersTag,
    required this.searchAddresses,
    required this.getCoordinates,
    required this.formatAddress,
    required this.stopLoading,
    required this.setAddresses,
    required this.addressesModel,
    required this.shouldHideSize,
    required this.setShouldHideSize,
    required this.isLoadingPage,
    required this.mapController,
    required this.addMarker,
    required this.fetchRoute,
    required this.routePoints,
    required this.getUserCurrentAddress,
    required this.generateTest,
    required this.createDanger,
    required this.addMarkerTest,
  });

  final TextStyle selectedTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final TextStyle unselectedTextStyle = TextStyle(
    color: global.secondary,
    fontWeight: FontWeight.bold,
  );

  void moveCamera(LatLng point) {
    mapController.move(point, 17);
  }

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return isLoadingPage
            ? const CustomLoader()
            : Scaffold(
                resizeToAvoidBottomInset: false,
                floatingActionButton: Transform.scale(
                  scale: 1.5,
                  child: FloatingActionButton(
                    backgroundColor: global.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {
                      showIncidentDialog(context);
                    },
                    child: const Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    const SizedBox(),
                    PopupScope(
                      popupController: popupcontroller,
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: points[0],
                          initialZoom: 14,
                          maxZoom: 20,
                          onTap: (_, __) {
                            popupcontroller.hideAllPopups();
                            FocusScope.of(context).unfocus();
                            setShouldHideSize(true);
                          },
                        ),
                        children: <Widget>[
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                                ),
                              ),
                              builder: (context, markers) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: global.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      markers.length.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: routePoints,
                                strokeWidth: 4.0,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 15, left: 4.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: global.primary,
                                    borderRadius: BorderRadius.circular(30),
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
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (value) {
                                      searchAddresses(value)
                                          .then((addresses) async {
                                        if (addresses.isNotEmpty) {
                                          try {
                                            setShouldHideSize(true);
                                            setAddresses(addresses);
                                            stopLoading();
                                          } catch (error) {
                                            setShouldHideSize(false);
                                            debugPrint(
                                                'Error getting coordinates: $error');
                                          }
                                        } else {
                                          debugPrint('No addresses found');
                                          setAddresses(addresses);
                                          stopLoading();
                                          setShouldHideSize(false);
                                        }
                                      }).catchError((error) {
                                        setAddresses(null);
                                        stopLoading();
                                        setShouldHideSize(false);
                                        debugPrint(
                                            'Error searching addresses: $error');
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        isLoading
                            ? Container(
                                color: Colors.white,
                                margin: const EdgeInsets.all(8.0),
                                child: loaderInSizedBox())
                            : addressesModel.isNotEmpty
                                ? IntrinsicHeight(
                                    child: Container(
                                      color: Colors.white,
                                      margin: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: addressesModel
                                                .map<Widget>((address) {
                                              String formattedAddress =
                                                  formatAddress(address);
                                              return ListTile(
                                                title: Text(formattedAddress),
                                                onTap: () async {
                                                  try {
                                                    debugPrint(
                                                        'Getting coordinates for address: $address');
                                                    Map<String, double>
                                                        coordinates =
                                                        await getCoordinates(
                                                            address);
                                                    LatLng newPoint = LatLng(
                                                        coordinates[
                                                            'latitude']!,
                                                        coordinates[
                                                            'longitude']!);
                                                    addMarker(newPoint);
                                                    moveCamera(newPoint);
                                                    // lancer la recherche de l'itinéraire
                                                    // String userCurrentAddress = await getUserCurrentAddress();
                                                    // List<Location> locations = await locationFromAddress(userCurrentAddress);
                                                    // Location userCurrentLocation = locations[0];

                                                    // fetchRoute(LatLng(userCurrentLocation.latitude, userCurrentLocation.longitude), LatLng(coordinates['latitude']!, coordinates['longitude']!));

                                                    fetchRoute(
                                                        points[0],
                                                        LatLng(
                                                            coordinates[
                                                                'latitude']!,
                                                            coordinates[
                                                                'longitude']!));
                                                  } catch (error) {
                                                    debugPrint(
                                                        'Error getting coordinates: $error');
                                                  }
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : hideSizedBox(shouldHideSize),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
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
                                      updateMarkersTag(selectedIndices);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedIndices.contains(index)
                                            ? global.secondary
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            incidentType.icon,
                                            color:
                                                selectedIndices.contains(index)
                                                    ? Colors.white
                                                    : global.secondary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            incidentType.name,
                                            style:
                                                selectedIndices.contains(index)
                                                    ? selectedTextStyle
                                                    : unselectedTextStyle,
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
                    ),
                  ],
                ),
              );
      },
    );
  }

  loaderInSizedBox() {
    return const SizedBox(
      height: 100,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget hideSizedBox(bool shouldHide) {
    return shouldHide
        ? Container(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: const SizedBox())
        : Container(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Aucun résultat trouvé',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ));
  }

  void showIncidentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedButton = '';

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Signaler un incident',
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 200,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButton = 'travaux';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: selectedButton == 'travaux'
                                ? Colors.grey
                                : Colors.white,
                          ),
                          child: Icon(
                            Icons.engineering,
                            color: global.secondary,
                            size: 70,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButton = 'accident';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: selectedButton == 'accident'
                                ? Colors.grey
                                : Colors.white,
                          ),
                          child: Icon(
                            Icons.car_crash,
                            color: global.secondary,
                            size: 70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButton = 'inondation';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: selectedButton == 'inondation'
                                ? Colors.grey
                                : Colors.white,
                          ),
                          child: Icon(
                            Icons.flood,
                            color: global.secondary,
                            size: 70,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButton = 'danger';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: selectedButton == 'danger'
                                ? Colors.grey
                                : Colors.white,
                          ),
                          child: Icon(
                            Icons.report,
                            color: global.secondary,
                            size: 70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (selectedButton.isNotEmpty) {
                          LatLng coordinates = generateTest();

                          // ViewModel viewModel = ViewModel(
                          //   mapController: mapController,
                          //   markers: markers,
                          // );
                          //createDanger(selectedButton, coordinates);
                          
                          addMarkerTest(coordinates, selectedButton);

                          // addMarker(coordinates);
                          // addIncidentMarker(coordinates, selectedButton);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: global.secondary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 36),
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text(
                        'SIGNALER',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: global.tertiary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 36),
                          padding: const EdgeInsets.symmetric(vertical: 10)),
                      child: const Text(
                        'ANNULER',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
