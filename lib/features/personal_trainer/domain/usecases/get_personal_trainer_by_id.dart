import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/domain/repositories/personal_trainer_repository.dart';

class GetPersonalTrainerById extends UseCase<PersonalTrainer, Params> {
  final PersonalTrainerRepository repository;

  GetPersonalTrainerById(this.repository);

  @override
  Future<Either<Failure, PersonalTrainer>> call(Params params) async {
    return repository.getPersonalTrainerById(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id}) : super([id]);
}
