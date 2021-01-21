import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PersonalTrainerEvent extends Equatable {
  PersonalTrainerEvent([List props = const <dynamic>[]]) : super(props);
}

class GetPersonalTrainerForId extends PersonalTrainerEvent {
  final String idString;

  GetPersonalTrainerForId(this.idString) : super([idString]);
}

class GetForAllPersonalTrainers extends PersonalTrainerEvent {}