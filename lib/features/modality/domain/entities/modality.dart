import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Modality extends Equatable {
  final int id;
  final String label;
  final String description;
  final int duration;

  Modality({
    @required this.id,
    @required this.label,
    @required this.description,
    @required this.duration,
  }) : super([id, label, description, duration]);
}