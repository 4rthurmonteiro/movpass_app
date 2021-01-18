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
}