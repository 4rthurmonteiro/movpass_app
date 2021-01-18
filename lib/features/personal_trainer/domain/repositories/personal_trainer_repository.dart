import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/personal_trainer.dart';

abstract class PersonalTrainerRepository {
  Future<Either<Failure, List<PersonalTrainer>>> getAllPersonalTrainers();
  Future<Either<Failure, PersonalTrainer>> getPersonalTrainerById(int id);
}