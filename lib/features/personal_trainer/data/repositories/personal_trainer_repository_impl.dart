import 'package:dartz/dartz.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/domain/repositories/personal_trainer_repository.dart';

class PersonalTrainerRepositoryImpl implements PersonalTrainerRepository {
  @override
  Future<Either<Failure, List<PersonalTrainer>>> getAllPersonalTrainers() {
    // TODO: implement getAllPersonalTrainers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PersonalTrainer>> getPersonalTrainerById(int id) {
    // TODO: implement getPersonalTrainerById
    throw UnimplementedError();
  }

}