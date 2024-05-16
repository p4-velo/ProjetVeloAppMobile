import 'dart:async';

class AdresseModel {
  List<String> _adresses = [];
  StreamController<List<String>> _adressesController = StreamController<List<String>>.broadcast();

  // Écouteurs pour la liste des adresses
  Stream<List<String>> get adressesStream => _adressesController.stream;

  // Ajouter une nouvelle adresse
  void addAdresse(String nouvelleAdresse) {
    _adresses.add(nouvelleAdresse);
    _adressesController.add(_adresses.toList());
  }

  // Obtenez la liste actuelle des adresses
  List<String> get adresses => _adresses.toList();

  // Nettoyer le contrôleur de flux
  void dispose() {
    _adressesController.close();
  }
}
