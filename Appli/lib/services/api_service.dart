import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../POO/ArceauxVelos.dart';

class ApiService {
  static const String url = "https://dijon-metropole.opendatasoft.com/api/explore/v2.1/catalog/datasets/arceaux-velos/exports/json?lang=fr&timezone=Europe%2FBerlin";

  Future<List<ArceauxVelos>> fetchArceauxVelos() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ArceauxVelos> arceauxVelosList = [];
      int id = 1;
      for (var item in data) {
        if (item['nb_arceaux'] != null && item['geo_shape']['geometry']['coordinates'] != null) {
          arceauxVelosList.add(ArceauxVelos.fromJson(item, id));
          id++;
          // int test1234 = arceauxVelosList.length;
          // debugPrint("$test1234");
        }
      }
      return arceauxVelosList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
