import 'IncidentType.dart';
import 'Localisation.dart';

class Incident {
  final int id;
  final IncidentType incidentType;
  final Localisation localisation;

  Incident({required this.id, required this.incidentType, required this.localisation});
}