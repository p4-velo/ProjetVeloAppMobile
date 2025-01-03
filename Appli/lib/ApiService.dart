import 'dart:convert';
import 'package:http/http.dart' as http;
import 'POO/ArceauxVelos.dart';
import 'POO/FavoritePlace.dart';

class ApiService {

  ApiService();

  Future<List<FavoritePlace>> fetchFavoritePlaces(int id) async {
    final response = await http.get(Uri.parse('https://wa-prod-vel-01.azurewebsites.net/api/FavoritePlace/User/$id'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<FavoritePlace> places = body.map((dynamic item) => FavoritePlace.fromJson(item)).toList();
      return places;
    } else {
      throw Exception('Failed to load favorite places');
    }
  }

  Future<void> deleteFavoritePlace(int id) async {
    final response = await http.delete(Uri.parse('https://wa-prod-vel-01.azurewebsites.net/api/FavoritePlace/$id'));

    if (response.statusCode == 204) {
      // Suppression réussie (204 No Content)
      print('Favorite place with id $id deleted successfully');
    } else {
      // Gestion des erreurs
      throw Exception('Failed to delete favorite place with id $id');
    }
  }

  Future<List<ArceauxVelos>> fetchArceauxVelos() async {
    final response = await http.get(Uri.parse("https://dijon-metropole.opendatasoft.com/api/explore/v2.1/catalog/datasets/arceaux-velos/exports/json?lang=fr&timezone=Europe%2FBerlin"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArceauxVelos> arceauxVelosList = [];
      int id = 1;
      for (var item in data) {
        if (item['nb_arceaux'] != null && item['geo_shape']['geometry']['coordinates'] != null) {
          arceauxVelosList.add(ArceauxVelos.fromJson(item, id));
          id++;
        }
      }
      return arceauxVelosList;
    } else {
      throw Exception('Failed to load data');
    }
  }

}
