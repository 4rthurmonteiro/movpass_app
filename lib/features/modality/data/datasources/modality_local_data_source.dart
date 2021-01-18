import 'package:movpass_app/features/modality/data/models/modality_model.dart';

abstract class ModalityLocalDataSource{

  Future<List<ModalityModel>> getAllModalities();

  Future<ModalityModel> getModalityById(int id);

  Future<void> cacheModality(ModalityModel modalityCache);

  Future<void> cacheModalities(List<ModalityModel> modalityCacheList);

}