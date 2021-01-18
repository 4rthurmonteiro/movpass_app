import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

class PersonalTrainer extends Equatable {
  final String cref;
  final String email;
  final int id;
  final List<Modality> modalities;
  final String name;

  PersonalTrainer({
    @required this.cref,
    @required this.email,
    @required this.id,
    @required this.modalities,
    @required this.name
  }) : super([id, cref, email, modalities, name]);
}
