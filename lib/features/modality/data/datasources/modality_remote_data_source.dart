import 'package:movpass_app/features/modality/data/models/modality_model.dart';

abstract class ModalityRemoteDataSource {

  Future<List<ModalityModel>> getAllModalities();

  Future<ModalityModel> getModalityById(int id);

}