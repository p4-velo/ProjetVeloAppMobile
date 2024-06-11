
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletton_projet_velo/global.dart' as global;
import 'package:skeletton_projet_velo/widgets/CustomWidget/CustomLoader/view_model.dart';
import '../../../POO/IncidentType.dart';
import '../../../POO/DangerType.dart';
import 'view_model.dart';


class MobileView {
  BuildContext context;
  PopupController popupcontroller;
  List<Marker> markers;
  List<LatLng> points;
  List<IncidentType> incidentsTypes;
  List<int> selectedIndices;
  Function updateMarkersTag;
  Function searchAddresses;
  Function getCoordinates;
  Function formatAddress;
  List<String> addressesModel;
  MapController mapController;
  Function addMarker;
  Function fetchRoute;
  List<LatLng> routePoints;
  Function getCurrentLocation;
  Map<Permission, PermissionStatus> permissionStatus;


  List<DangerType> dangerTypes;
  Function addCustomMarkerCallback;

  //fonction de classe
  bool isLoadingPage = false;
  bool isLoading = false;
  bool shouldHideSize = true;





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
    required this.dangerTypes,
    required this.addCustomMarkerCallback,
    required this.fetchRoute,
    required this.routePoints,
    required this.getCurrentLocation,
    required this.permissionStatus,
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
        return isLoadingPage
            ? const CustomLoader()
            : Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: Transform.scale(
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
                      setState(() {
                        shouldHideSize = true;
                      });
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
              ),
              Column(
                children: [
                  Padding(
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
                                setState(() {
                                  isLoading = true;
                                });
                                searchAddresses(value).then((addresses) async {
                                  if (addresses.isNotEmpty) {
                                    try {
                                      setState(() {
                                        shouldHideSize = true;
                                        addressesModel = addresses;
                                        isLoading = false;
                                      });
                                    } catch (error) {
                                      setState(() {
                                        shouldHideSize = false;
                                      });
                                      debugPrint('Error getting coordinates: $error');
                                    }
                                  } else {
                                    debugPrint('No addresses found');
                                    setState(() {
                                      addressesModel = addresses;
                                      isLoading = false;
                                      shouldHideSize = false;
                                    });
                                  }
                                }).catchError((error) {
                                  setState(() {
                                    addressesModel = [];
                                    isLoading = false;
                                    shouldHideSize = false;
                                  });
                                  debugPrint('Error searching addresses: $error');
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
                    child: loaderInSizedBox(),
                  )
                      : addressesModel.isNotEmpty
                      ? IntrinsicHeight(
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
                                  setState(() {
                                    // isLoadingPage = true;
                                  });
                                  try {
                                    debugPrint('Getting coordinates for address: $address');
                                    Map<String, double> coordinates = await getCoordinates(address);
                                    LatLng endPoint = LatLng(coordinates['latitude']!, coordinates['longitude']!);
                                    moveCamera(endPoint);
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
                  )
                      : hideSizedBox(shouldHideSize),
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
                                  color: selectedIndices.contains(index) ? global.secondary : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      incidentType.icon,
                                      color: selectedIndices.contains(index) ? Colors.white : global.secondary,
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
              ),
            ],
          ),
        );
      },
    );

  }

  loaderInSizedBox({double size = 100}) {
    return  SizedBox(
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
        color: isInPopup ?  Colors.transparent: Colors.white,
        margin: isInPopup ? const EdgeInsets.all(0) : const EdgeInsets.all(8.0),
        child : const SizedBox()
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
        return AlertDialog(
          title: const Text(
            'Signaler un incident',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: 200,
            height: 250,
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    addCustomMarkerCallback();
                    print("travaux");
                  },
                  child: Icon(
                    Icons.engineering,
                    color: global.secondary,
                    size: 50,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("accident");
                  },
                  child: Icon(
                    Icons.car_crash,
                    color: global.secondary,
                    size: 50,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("innondation");
                  },
                  child: Icon(
                    Icons.flood,
                    color: global.secondary,
                    size: 50,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("danger");
                  },
                  child: Icon(
                    Icons.report,
                    color: global.secondary,
                    size: 50,
                  ),
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Signaler'),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            List<String> _favoriteAddresses = ['Adresse 1', 'Adresse 2', 'Adresse 3'];

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

  void showPopupWithSimpleRadioChoose(BuildContext context, LatLng endPoint, void Function(void Function()) setState) {

    int? selectedOption; // Variable pour stocker la valeur sélectionnée
    String address = '';
    bool isLoadingPopUp = false;
    String inputText = '';
    String addressStartPoint = '';
    String? selectedFavoriteAddress;
    List<String> favoriteAddresses = ['Adresse 1', 'Adresse 2', 'Adresse 3'];
    setState(() {
      isLoadingPage = false;
    });



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
                height: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RadioListTile<int>(
                      title: const Text('Ma localisation'), // Texte de la première option
                      value: 1, // Valeur associée à la première option
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
                            // Utilisez une expression conditionnelle pour définir la couleur du texte
                            // Si inputText est non vide, le texte sera noir, sinon il sera gris
                            // Vous pouvez ajuster les couleurs selon vos préférences
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
                            searchAddresses(value).then((addresses) async {
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
                      child :loaderInSizedBox(size: 20)
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

                                  String formattedAddress = formatAddress(address);
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
                                        debugPrint('Error getting coordinates: $error');
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
                        items: favoriteAddresses.map((String address) {
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
                    )

                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    if (selectedOption != null) {
                      switch (selectedOption) {
                        case 1:
                          checkPermissionAndFetchLocation(context);
                          break;
                        case 2:
                          debugPrint('Start with address: $addressStartPoint');
                          if (addressStartPoint.isEmpty) {
                            debugPrint('No address selected');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Adresse de départ non sélectionnée'),
                                  content: const Text('Vous devez renseigner une adresse de départ.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                      },
                                      child: Text('Fermer'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            debugPrint('Start with address: $addressStartPoint');
                            Map<String, double> coordinates = await getCoordinates(addressStartPoint);
                            LatLng startPoint = LatLng(coordinates['latitude']!, coordinates['longitude']!);
                            await fetchRoute(startPoint, endPoint);
                            Navigator.of(context).pop(); // Fermer la boîte de dialogue après avoir terminé
                          }
                          break;
                        case 3:
                          print('Option 3 selected');
                          Navigator.of(context).pop(); // Fermer la boîte de dialogue après avoir terminé
                          break;
                      }
                    }
                  },
                  child: const Text('Choisir'),
                ),



              ],
            );
          },
        );
      },
    );
  }


  Future<void> checkPermissionAndFetchLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      LatLng userLocation = await getCurrentLocation();
      await fetchRoute(userLocation, points.first);
      debugPrint('Start with my localisation');
      Navigator.of(context).pop(); // Fermer la boîte de dialogue si la permission est accordée
    } else {
      // Afficher une boîte de dialogue native
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
  }
}

Future<void> checkPermission(Permission permission, BuildContext context) async {
  final status = await permission.request();
  if (status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permission Granted'),
      ),
    );
  } else if (status.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permission Denied'),
      ),
    );
  } else if (status.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permission Permanently Denied'),
      ),
    );
  }
}


