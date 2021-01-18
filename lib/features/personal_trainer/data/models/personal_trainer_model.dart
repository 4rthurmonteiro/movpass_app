import 'package:meta/meta.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

import '../../domain/entities/personal_trainer.dart';

class PersonalTrainerModel extends PersonalTrainer {
  PersonalTrainerModel({
    @required String cref,
    @required String email,
    @required int id,
    @required List<Modality> modalities,
    @required String name
  }) : super(
    cref: cref,
    email: email,
    id: id,
    modalities: modalities,
    name: name
  );
}