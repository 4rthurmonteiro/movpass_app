import 'package:dartz/dartz.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/domain/repositories/personal_trainer_repository.dart';

class GetAllPersonalTrainers extends UseCase<List<PersonalTrainer>, NoParams> {
  final PersonalTrainerRepository repository;

  GetAllPersonalTrainers(this.repository);

  @override
  Future<Either<Failure, List<PersonalTrainer>>> call(NoParams params) async {
    return repository.getAllPersonalTrainers();
  }
}