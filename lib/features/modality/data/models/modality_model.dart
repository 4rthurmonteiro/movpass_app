import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:meta/meta.dart';

class ModalityModel extends Modality {
  ModalityModel({
    @required int id,
    @required String label,
    @required String description,
    @required int duration
  }) : super(
      label: label,
      description: description,
      id: id,
      duration: duration,
  );

  factory ModalityModel.fromJson(Map<String, dynamic> json) {
    return ModalityModel(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String,
      description: json['description'] as String,
      duration: (json['duration'] as num).toInt(),

    );
  }
}