import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

@immutable
abstract class ModalityState extends Equatable {
  ModalityState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends ModalityState {}

class Loading extends ModalityState {}

class Loaded extends ModalityState {
  final Modality modality;

  Loaded({@required this.modality}) : super([modality]);
}

class LoadedAll extends ModalityState {
  final List<Modality> modalities;

  LoadedAll({@required this.modalities}) : super([modalities]);
}

class Error extends ModalityState {
  final String message;

  Error({@required this.message}) : super([message]);
}