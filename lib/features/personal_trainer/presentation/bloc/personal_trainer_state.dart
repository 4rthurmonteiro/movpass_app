import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';

@immutable
abstract class PersonalTrainerState extends Equatable {
  PersonalTrainerState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends PersonalTrainerState {}

class Loading extends PersonalTrainerState {}

class Loaded extends PersonalTrainerState {
  final PersonalTrainer personalTrainer;

  Loaded({@required this.personalTrainer}) : super([PersonalTrainer]);
}

class LoadedAll extends PersonalTrainerState {
  final List<PersonalTrainer> personalTrainers;

  LoadedAll({@required this.personalTrainers}) : super([personalTrainers]);
}

class Error extends PersonalTrainerState {
  final String message;

  Error({@required this.message}) : super([message]);
}