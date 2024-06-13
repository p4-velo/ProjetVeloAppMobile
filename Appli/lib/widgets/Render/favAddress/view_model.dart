import 'package:flutter/material.dart';
import 'package:projet_velo_app_mobile/POO/fav_address_infos.dart';
import 'package:projet_velo_app_mobile/providers/test_provider.dart';
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
  List<FavAddressInfo> favAddressList = [
    FavAddressInfo(name: 'Maison', address: '35 Rue Béranger, 21000 Dijon'),
    FavAddressInfo(name: 'Travail', address: '26 Bd Georges Clemenceau, 21000 Dijon'),
    FavAddressInfo(name: 'Salle de sport', address: '56 Av. du Drapeau, 21000 Dijon'),
    FavAddressInfo(name: 'Adresse favorite 1', address: '19 Rue du Nivernais, 21121 Fontaine-lès-Dijon'),
  ];
  String text = "Failed";

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
    super.initState();
  }

  Future<void> getTexteTest() async {
  startLoading();
  try {
    TestProvider testProvider = TestProvider();
    text = await testProvider.getTest();
  } catch (e) {
    print("Erreur requête");
  }
  stopLoading();
}
  
  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      favAddressList: favAddressList,
      getTexteTest: getTexteTest,
      text: text
    );

    return currentView.render();
  }
}
