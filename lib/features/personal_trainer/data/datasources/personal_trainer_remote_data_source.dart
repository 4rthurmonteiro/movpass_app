import 'package:movpass_app/features/personal_trainer/data/models/personal_trainer_model.dart';

abstract class PersonalTrainerRemoteDataSource {

  Future<List<PersonalTrainerModel>> getAlPersonalTrainers();

  Future<PersonalTrainerModel> getPersonalTrainerById(int id);

}