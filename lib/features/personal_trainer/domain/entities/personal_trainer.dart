import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';

class PersonalTrainer extends Equatable {
  final String cref;
  final String email;
  final int id;
  final List<ModalityModel> modalities;
  final String name;

  PersonalTrainer({
    @required this.cref,
    @required this.email,
    @required this.id,
    @required this.modalities,
    @required this.name
  }) : super([id, cref, email, modalities, name]);
}
