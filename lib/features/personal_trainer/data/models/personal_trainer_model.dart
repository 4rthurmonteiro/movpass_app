import 'package:meta/meta.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

import '../../domain/entities/personal_trainer.dart';

class PersonalTrainerModel extends PersonalTrainer {
  PersonalTrainerModel({
    @required String cref,
    @required String email,
    @required int id,
    @required List<ModalityModel> modalities,
    @required String name
  }) : super(
    cref: cref,
    email: email,
    id: id,
    modalities: modalities,
    name: name
  );

  factory PersonalTrainerModel.fromJson(Map<String, dynamic> json) {
    return PersonalTrainerModel(
      id: (json['id'] as num).toInt(),
      cref: json['cref'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      modalities: parseFiles(json)
    );
  }

  static List<ModalityModel> parseFiles(filesJson) {
    var list = filesJson["modalities"] as List;

    List<ModalityModel> modalitiesList = list == null
        ? null
        : list.map((data) => ModalityModel.fromJson(data as Map<String, dynamic>)).toList();

    return modalitiesList;
  }

}