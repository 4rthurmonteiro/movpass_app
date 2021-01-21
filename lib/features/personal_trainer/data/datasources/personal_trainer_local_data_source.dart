import 'package:movpass_app/core/database/base_dao.dart';
import 'package:movpass_app/core/database/database_helper.dart';
import 'package:movpass_app/features/personal_trainer/data/models/personal_trainer_model.dart';
import 'package:meta/meta.dart';

abstract class PersonalTrainerLocalDataSource{

  Future<List<PersonalTrainerModel>> getAllPersonalTrainers();

  Future<void> cachePersonalTrainer(PersonalTrainerModel personalTrainerCache);

  Future<PersonalTrainerModel> getPersonalTrainerById(int id);


  void cachePersonalTrainers(List<PersonalTrainerModel> personalTrainerCacheList);
}

class PersonalTrainerLocalDataSourceImpl extends BaseDao<PersonalTrainerModel> implements PersonalTrainerLocalDataSource {
  final DatabaseHelper databaseHelper;

  PersonalTrainerLocalDataSourceImpl({
    @required this.databaseHelper
  });

  @override
  void cachePersonalTrainers(List<PersonalTrainerModel> personalTrainerCacheList) {
    for(PersonalTrainerModel m in personalTrainerCacheList){
      save(m);
    }
  }

  @override
  Future<void> cachePersonalTrainer(PersonalTrainerModel personalTrainerCache) {
    return save(personalTrainerCache);
  }

  @override
  Future<List<PersonalTrainerModel>> getAllPersonalTrainers() {
    return findAll();
  }

  @override
  Future<PersonalTrainerModel> getPersonalTrainerById(int id) {
    return findById(id);
  }

  @override
  PersonalTrainerModel fromJson(Map<String, dynamic> map) {
    return PersonalTrainerModel.fromJson(map);
  }

  @override
  String get tableName => 'PersonalTrainer';

}