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


  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      favAddressList: favAddressList,
    );

    return currentView.render();
  }
}
