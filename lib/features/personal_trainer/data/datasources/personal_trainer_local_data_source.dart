import 'package:movpass_app/features/personal_trainer/data/models/personal_trainer_model.dart';

abstract class PersonalTrainerLocalDataSource{

  Future<List<PersonalTrainerModel>> getAllPersonalTrainers();

  Future<bool> cachePersonalTrainer(PersonalTrainerModel personalTrainerCache);

}