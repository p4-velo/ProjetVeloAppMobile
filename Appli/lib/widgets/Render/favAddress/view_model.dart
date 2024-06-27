import 'package:flutter/material.dart';
import '../../../ApiService.dart';
import '../../../POO/FavoritePlace.dart';
import 'view.dart';

class FavAddress extends StatefulWidget {
  const FavAddress({super.key});

  @override
  FavAddressState createState() {
    return FavAddressState();
  }
}

class FavAddressState extends State<FavAddress> {
  bool isLoading = false;
  List<FavoritePlace> favAddressList = [];
  bool openAddFavWindow = false;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  bool isErrorName = false;
  bool isErrorAddress = false;
  String errorTypeName = "None";
  String errorTypeAddress = "None";

  @override
  void initState() {
    super.initState();
    fetchAndSetFavoritePlaces();
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchAndSetFavoritePlaces() async {
    startLoading();
    try {
      ApiService apiService = ApiService();
      List<FavoritePlace> favoritePlaces = await apiService.fetchFavoritePlaces(1);

      setState(() {
        favAddressList = favoritePlaces;
      });
    } catch (e) {
      print("Erreur requête: $e");
    }
    stopLoading();
  }

  void openAddFavWindowCall() {
    setState(() {
      openAddFavWindow = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      favAddressList: favAddressList,
      openAddFavWindow: openAddFavWindow,
      openAddFavWindowCall: openAddFavWindowCall,
      controllerName: controllerName,
      controllerAddress: controllerAddress,
      isErrorName: isErrorName,
      isErrorAddress: isErrorAddress,
      errorTypeName: errorTypeName,
      errorTypeAddress: errorTypeAddress
    );

    return currentView.render();
  }
}
