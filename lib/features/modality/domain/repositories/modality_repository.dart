import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/modality.dart';

abstract class ModalityRepository {
  Future<Either<Failure, List<Modality>>> getAllModalities();

  Future<Either<Failure, Modality>> getModalityById(int id);
}