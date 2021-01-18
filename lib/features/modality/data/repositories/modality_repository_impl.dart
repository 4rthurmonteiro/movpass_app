import 'package:dartz/dartz.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';

class ModalityRepositoryImpl implements ModalityRepository {
  @override
  Future<Either<Failure, List<Modality>>> getAllModalities() {
    // TODO: implement getAllModalities
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Modality>> getModalityById(int id) {
    // TODO: implement getModalityById
    throw UnimplementedError();
  }

}