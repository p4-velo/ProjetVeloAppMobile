import 'DangerType.dart';
import 'Localisation.dart';

class Danger {
  final int id;
  final DangerType dangerType;
  final Localisation localisation;

  Danger({required this.id, required this.dangerType, required this.localisation});
}