import 'Localisation.dart';

class ArceauxVelos {
  final int id;
  final int nbArceaux;
  final Localisation localisation;

  ArceauxVelos({required this.id, required this.nbArceaux, required this.localisation});

  factory ArceauxVelos.fromJson(Map<String, dynamic> json, int id) {
    return ArceauxVelos(
      id: id,
      nbArceaux: json['nb_arceaux'],
      localisation: Localisation.fromJson(json['geo_shape']['geometry']['coordinates'], id),
    );
  }
}