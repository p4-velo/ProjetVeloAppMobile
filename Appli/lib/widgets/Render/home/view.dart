
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletton_projet_velo/global.dart' as global;
import 'package:skeletton_projet_velo/widgets/CustomWidget/CustomLoader/view_model.dart';
import '../../../POO/IncidentType.dart';



class MobileView {
  BuildContext context;
  PopupController popupcontroller;
  List<Marker> markers;
  List<LatLng> points;
  List<IncidentType> incidentsTypes;
  List<int> selectedIndices;
  final void Function(List<int>) updateMarkersTag;
  Function searchAddresses;
  Function getCoordinates;
  Function formatAddress;
  List<String> addressesModel;
  MapController mapController;
  Function addMarker;
  Function fetchRoute;
  Function navigation;

  Function getDistance;
  Function getIncidentCount;

  List<LatLng> routePoints;
  Function getCurrentLocation;
  Map<Permission, PermissionStatus> permissionStatus;

  Function createDanger;
  Function addMarkerTest;
  Function generateTest;
  LatLng? currentPosition;
  bool internetLoading;
  bool isLoading;
  bool shouldHideSize;
  Function performSearch;
  Function checkInternetConnection;
  bool hasUserLocation;
  bool? hasLocalisationPermission;
  bool isLoadingPage;
  bool showAddress;
  bool isNavigating;

  MobileView({
    required this.context,
    required this.popupcontroller,
    required this.markers,
    required this.points,
    required this.incidentsTypes,
    required this.selectedIndices,
    required this.updateMarkersTag,
    required this.searchAddresses,
    required this.getCoordinates,
    required this.formatAddress,
    required this.addressesModel,
    required this.mapController,
    required this.addMarker,
    required this.fetchRoute,
    required this.routePoints,
    required this.getCurrentLocation,
    required this.permissionStatus,
    required this.generateTest,
    required this.createDanger,
    required this.addMarkerTest,
    required this.navigation,
    required this.getDistance,
    required this.getIncidentCount,
    required this.currentPosition,
    required this.internetLoading,
    required this.isLoading,
    required this.shouldHideSize,
    required this.performSearch,
    required this.checkInternetConnection,
    required this.hasUserLocation,
    required this.hasLocalisationPermission,
    required this.isLoadingPage,
    required this.showAddress,
    required this.isNavigating,
  });

  final TextStyle selectedTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final TextStyle unselectedTextStyle = TextStyle(
    color: global.secondary,
    fontWeight: FontWeight.bold,
  );

  double getHeight(bool isInPopup) {
    return isInPopup ? 100 : 200;
  }

  void moveCamera(LatLng point) {
    mapController.move(point, 17);
  }


  render() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {


        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: buildFloatingButtons(context, isNavigating),
          body: Stack(
            children: [
              const SizedBox(),

              buildMapWidget(
                popupcontroller: popupcontroller,
                mapController: mapController,
                currentPosition: currentPosition,
                points: points,
                markers: markers,
                routePoints: routePoints,
                context: context,
                shouldHideSize: shouldHideSize,
                setState: setState,
              ),

              Column(
                children: [
                  // Display the message if location permission is not granted
                  hasLocalisationPermission != null && !hasLocalisationPermission!
                      ? buildLocationWarning() : Container(),
                  buildInputSearch(context, setState),
                  isLoading
                      ? loaderInSizedBox()
                      : addressesModel.isNotEmpty && showAddress
                      ? buildListAddressResult(
                    addressesModel: addressesModel,
                    context: context,
                    setState: setState,
                  )
                      :  !showAddress ? hideSizedBox(shouldHideSize) : Container(),
                  buildTagList(
                    incidentsTypes: incidentsTypes,
                    selectedIndices: selectedIndices,
                    setState: setState,
                    context: context,
                    updateMarkersTag: updateMarkersTag,
                    selectedTextStyle: selectedTextStyle,
                    unselectedTextStyle: unselectedTextStyle,
                  ),
                  internetLoading
                      ? buildInternetDialog(context)
                      : !hasUserLocation && hasLocalisationPermission != null && hasLocalisationPermission!  && !internetLoading
                      ? buildLoaderMyLoacalisation(context)
                      : Container(),
                  if(isLoadingPage) Expanded(child :loaderInSizedBox(size: 50),),
                ],
              ),
            ],
          ),
        );
      },
    );
  }



  loaderInSizedBox({double size = 100}) {
    return SizedBox(
      height: size,
      width: size,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget hideSizedBox(bool shouldHideSize, { bool isInPopup = false}) {
    return shouldHideSize
        ? Container(
        color: isInPopup ? Colors.transparent : Colors.white,
        margin: isInPopup ? const EdgeInsets.all(0) : const EdgeInsets.all(8.0),
        child: const SizedBox()
    )

        : Container(
      color: isInPopup ? Colors.transparent : Colors.white,
      margin: isInPopup ? const EdgeInsets.all(0) : const EdgeInsets.all(8.0),
      child: SizedBox(
        height: isInPopup ? 50 : 100,
        child: const Center(
          child: Text(
            'Aucun résultat trouvé',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
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
                          // LatLng coordinates = generateTest();
                          // addMarkerTest(coordinates, selectedButton);
                          checkPermissionAndAddMarkerTest(selectedButton);
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


  void showChooseStartLocation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int selectedOption = 0;
            TextEditingController addressController = TextEditingController();
            String? _selectedFavoriteAddress;
            List<String> _favoriteAddresses = [
              'Adresse 1',
              'Adresse 2',
              'Adresse 3'
            ];

            return AlertDialog(
              title: const Text(
                'Choisissez le départ:',
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 200,
                height: 300,
                child: Column(
                  children: [
                    RadioListTile<int>(
                      title: Text('Ma localisation'),
                      value: 0,
                      groupValue: selectedOption,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                    ListTile(
                      leading: Radio<int>(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      title: TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Entrer une adresse',
                          enabled: selectedOption == 1,
                        ),
                        enabled: selectedOption == 1,
                      ),
                      onTap: () {
                        setState(() {
                          selectedOption = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      title: DropdownButton<String>(
                        value: _selectedFavoriteAddress,
                        items: _favoriteAddresses.map((String address) {
                          return DropdownMenuItem<String>(
                            value: address,
                            child: Text(address),
                          );
                        }).toList(),
                        onChanged: selectedOption == 2
                            ? (String? newValue) {
                          setState(() {
                            _selectedFavoriteAddress = newValue!;
                          });
                        }
                            : null,
                        hint: Text('Mes adresses favoris'),
                      ),
                      onTap: () {
                        setState(() {
                          selectedOption = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Annuler'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showPopupWithSimpleRadioChoose(BuildContext context, LatLng endPoint,
      void Function(void Function()) setState) {
    int? selectedOption; // Variable pour stocker la valeur sélectionnée
    String address = '';
    bool isLoadingPopUp = false;
    String inputText = '';
    String addressStartPoint = '';
    String? selectedFavoriteAddress;
    List<String> favoriteAddresses = ['Adresse 1', 'Adresse 2', 'Adresse 3'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Choisissez l\'adresse de départ:',
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 400,
                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RadioListTile<int>(
                      title: const Text('Ma localisation'),
                      // Texte de la première option
                      value: 1,
                      // Valeur associée à la première option
                      groupValue: selectedOption,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: TextField(
                        maxLines: 2,
                        textInputAction: TextInputAction.search,
                        controller: TextEditingController(
                          text: inputText.isNotEmpty ? inputText : null,
                        ),
                        style: TextStyle(
                          color: inputText.isNotEmpty ? Colors.green : Colors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Recherchez une adresse',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            isLoadingPopUp = true;
                          });

                          searchAddresses(value, useLoader: false, showAddressOnHome : false).then((addresses) {
                            if (addresses.isNotEmpty) {
                              try {
                                setState(() {
                                  address = addresses[0];
                                  shouldHideSize = true;
                                  isLoadingPopUp = false;
                                });
                              } catch (error) {
                                setState(() {
                                  address = '';
                                  shouldHideSize = false;
                                  isLoadingPopUp = false;
                                });
                                debugPrint('Error getting coordinates: $error');
                              }
                            } else {
                              debugPrint('No addresses found');
                              setState(() {
                                address = '';
                                shouldHideSize = false;
                                isLoadingPopUp = false;
                              });
                            }
                          }).catchError((error) {
                            setState(() {
                              address = '';
                              shouldHideSize = false;
                              isLoadingPopUp = false;
                            });
                            debugPrint('Error searching addresses: $error');
                          });
                        },
                      ),
                      value: 2,
                      groupValue: selectedOption,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    isLoadingPopUp ?
                    Container(
                        color: Colors.transparent,
                        child: loaderInSizedBox(size: 20)
                    ) :
                    address.isNotEmpty ? IntrinsicHeight(
                      child: Container(
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Utiliser une variable pour le formattedAddress
                              Builder(
                                builder: (context) {
                                  String formattedAddress = formatAddress(
                                      address);
                                  return ListTile(
                                    title: Text(formattedAddress),
                                    onTap: () async {
                                      try {
                                        setState(() {
                                          inputText = formattedAddress;
                                          addressStartPoint = address;
                                          address = '';
                                        });
                                      } catch (error) {
                                        debugPrint(
                                            'Error getting coordinates: $error');
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        : hideSizedBox(shouldHideSize, isInPopup: true),
                    // hideSizedBox(shouldHideSize, isInPopup: true),
                    RadioListTile<int>(
                      title: DropdownButton<String>(
                        value: selectedFavoriteAddress,
                        items: favoriteAddresses
                            .map((String address) {
                          return DropdownMenuItem<String>(
                            value: address,
                            child: Text(address),
                          );
                        }).toList(),
                        onChanged: selectedOption == 3
                            ? (String? newValue) {
                                setState(() {
                                  selectedFavoriteAddress = newValue!;
                                });
                              }
                            : null,
                        hint: const Text('Mes favoris'),
                      ),
                      value: 3,
                      groupValue: selectedOption,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedOption != null) {
                        switch (selectedOption) {
                          case 1:
                            checkPermissionAndFetchLocation(context, endPoint);
                            Navigator.of(context).pop();

                            double distance = getDistance();
                            int incidentCount = getIncidentCount();
                            showRouteInfoDialog(context, distance, incidentCount);

                            break;
                          case 2:
                            debugPrint('Start with address: $addressStartPoint');
                            if (addressStartPoint.isEmpty) {
                              debugPrint('No address selected');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Adresse de départ non sélectionnée'),
                                    content: const Text(
                                        'Vous devez renseigner une adresse de départ.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Fermer la boîte de dialogue
                                        },
                                        child: Text('Fermer'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              debugPrint('Start with address: $addressStartPoint');
                              Map<String, double> coordinates =
                              await getCoordinates(addressStartPoint);
                              LatLng startPoint = LatLng(
                                  coordinates['latitude']!,
                                  coordinates['longitude']!);
                              await fetchRoute(startPoint, endPoint);
                              Navigator.of(context).pop(); // Fermer la boîte de dialogue après avoir terminé

                              // Afficher la nouvelle pop-up "Hello World"

                              double distance = getDistance();
                              int incidentCount = getIncidentCount();
                              showRouteInfoDialog(context, distance, incidentCount);
                            }
                            break;
                          case 3:
                            print('Option 3 selected');
                            Navigator.of(context).pop(); // Fermer la boîte de dialogue après avoir terminé
                            break;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: global.secondary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 36),
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text(
                      'CHOISIR',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showLocalisationPermissionDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Required'),
          content: Text('Vous devez accepter la localisation.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text('Fermer'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                await openAppSettings();
              },
              child: Text('Autoriser la localisation'),
            ),
          ],
        );
      },
    );
  }

  void showRouteInfoDialog(BuildContext context, double distance, int incidentCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informations sur le trajet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Distance à parcourir: ${distance.toStringAsFixed(2)} km'),
              Text('Nombre d\'incidents sur la route: $incidentCount'),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: global.tertiary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 36),
                    padding: const EdgeInsets.symmetric(vertical: 12), // Réduit le padding vertical
                  ),
                  child: const Text(
                    'Voir le trajet',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(width: 16), // Ajoute un espace de 16 pixels entre les boutons

                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    navigation(true);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: global.secondary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 36),
                    padding: const EdgeInsets.symmetric(vertical: 12), // Réduit le padding vertical
                  ),
                  child: const Text(
                    'Lancer navigation !',
                    style: TextStyle(
                      fontSize: 14,
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
  }

  Future<void> checkPermissionAndFetchLocation(BuildContext context,
      LatLng endPoint) async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      LatLng userLocation = await getCurrentLocation();
      await fetchRoute(userLocation, endPoint);
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildShowPermissionDialog(context);
        },
      );
    }
  }

  Future<bool> isLocationPermissionAutorised(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted ? true : false;
  }

  Future<void> checkPermissionAndAddMarkerTest(String selectedButton) async {
    bool isGranted = await isLocationPermissionAutorised(context);
    if (isGranted) {
      LatLng currentLocation = await getCurrentLocation();
      addMarkerTest(currentLocation, selectedButton);
    } else {
      showLocalisationPermissionDialog(context);
    }
  }

  Widget buildShowPermissionDialog(BuildContext context) {
    return Expanded(
      child :AlertDialog(
      title: const Text('Permission requise ou activation de la localisation requise.'),
      content: const Text('Vous devez accepter la localisation et / ou activer votre localisation.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Fermer'),
        ),
        TextButton(
          onPressed: () async {
            // Navigator.pop(context);
            await openAppSettings();
          },
          child: const Text('Autoriser la localisation'),
        ),
      ],
      ),
    );
  }

  Widget buildButtonIncident(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          showIncidentDialog(context);
        },
        child: Icon(
          Icons.warning,
          color: global.primary,
          size: 35,
        ),
      ),
    );
  }

  Widget buildButtonStartAndStopNavigation(BuildContext context, bool isNavigating) {
    return Transform.scale(
      scale: 1.3,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          navigation(false);

        },
        child: Icon(
          Icons.stop,
          color: global.primary,
          size: 35,
        ),
      ),
    );
  }


  Widget buildFloatingButtons(BuildContext context, bool isNavigating) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isNavigating) buildButtonStartAndStopNavigation(context, isNavigating),
        if (isNavigating) const SizedBox(height: 50),
        buildButtonIncident(context),
      ],
    );
  }


  Widget buildMapWidget({
    required PopupController popupcontroller,
    required MapController mapController,
    required LatLng? currentPosition,
    required List<LatLng> points,
    required List<Marker> markers,
    required List<LatLng> routePoints,
    required BuildContext context,
    required bool shouldHideSize,
    required StateSetter setState
  }) {
    return PopupScope(
      popupController: popupcontroller,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentPosition ?? points[0],
          initialZoom: 14,
          maxZoom: 20,
          onTap: (_, __) { // si on clique sur la map n'importe ou
            popupcontroller.hideAllPopups();
            FocusScope.of(context).unfocus();
          },
        ),

        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                popupBuilder: (_, marker) =>
                    Container(
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
                      style: const TextStyle(color: Colors.white),
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
    );
  }


  Widget buildInternetDialog(BuildContext context) {
    return Expanded(
      child: Center(
        child: AlertDialog(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Veuillez vous connecter à internet"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                checkInternetConnection();
              },
              child: const Text("Réessayer"),
            ),
          ],
        ),
      ),
    );
  }



  Widget buildLocationWarning() {
    return GestureDetector(
      onTap: openAppSettings,
      child: Container(
        width: double.infinity,
        color: Colors.red,
        padding: const EdgeInsets.all(8.0),
        child: const Text(
          "Vous n'avez pas activé ou autorisé la localisation sur votre appareil.",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  Widget buildLoaderMyLoacalisation(BuildContext context) {
    return const Expanded(
      child: Center(
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Chargement de votre localisation en cours..."),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildListAddressResult({
    required List<String> addressesModel,
    required BuildContext context,
    required Function(void Function()) setState,
  }) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: addressesModel.map<Widget>((address) {
                String formattedAddress = formatAddress(address);
                return ListTile(
                  title: Text(formattedAddress),
                  onTap: () async {
                    try {

                      debugPrint('Getting coordinates for address: $address');
                      Map<String, double> coordinates = await getCoordinates(address);
                      LatLng endPoint = LatLng(coordinates['latitude']!, coordinates['longitude']!);
                      showPopupWithSimpleRadioChoose(context, endPoint, setState);
                    } catch (error) {
                      debugPrint('Error getting coordinates: $error');
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }



  Widget buildInputSearch(BuildContext context, Function(void Function()) setState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15, left: 4.0),
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

                  performSearch(value);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTagList({
    required List<IncidentType> incidentsTypes,
    required List<int> selectedIndices,
    required Function(void Function()) setState,
    required BuildContext context,
    required void Function(List<int>) updateMarkersTag,
    required TextStyle selectedTextStyle,
    required TextStyle unselectedTextStyle,
  }) {
    return Padding(
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
                  setState(() {
                    if (selectedIndices.contains(index)) {
                      selectedIndices.remove(index);
                    } else {
                      selectedIndices.add(index);
                    }
                    updateMarkersTag(selectedIndices);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndices.contains(index)
                        ? global.secondary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        incidentType.icon,
                        color: selectedIndices.contains(index)
                            ? Colors.white
                            : global.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        incidentType.name,
                        style: selectedIndices.contains(index)
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
    );
  }


}


