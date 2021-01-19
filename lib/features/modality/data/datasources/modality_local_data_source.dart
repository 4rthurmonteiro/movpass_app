import 'package:movpass_app/core/database/base_dao.dart';
import 'package:movpass_app/core/database/database_helper.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

abstract class ModalityLocalDataSource{

  Future<List<ModalityModel>> getAllModalities();

  Future<ModalityModel> getModalityById(int id);

  Future<void> cacheModality(ModalityModel modalityCache);

  void cacheModalities(List<ModalityModel> modalityCacheList);

}

class ModalityLocalDataSourceImpl extends BaseDao<ModalityModel> implements ModalityLocalDataSource {
  final DatabaseHelper databaseHelper;

  ModalityLocalDataSourceImpl({
    @required this.databaseHelper
  });

  @override
  void cacheModalities(List<ModalityModel> modalityCacheList) {
    for(ModalityModel m in modalityCacheList){
      save(m);
    }
  }

  @override
  Future<int> cacheModality(ModalityModel modalityCache) {
    return save(modalityCache);
  }

  @override
  Future<List<ModalityModel>> getAllModalities() {
    return findAll();
  }

  @override
  Future<ModalityModel> getModalityById(int id) {
    return findById(id);
  }

  @override
  ModalityModel fromJson(Map<String, dynamic> map) {
   return ModalityModel.fromJson(map);
  }

  @override
  String get tableName => 'Modality';

}