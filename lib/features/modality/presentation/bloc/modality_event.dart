import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ModalityEvent extends Equatable {
  ModalityEvent([List props = const <dynamic>[]]) : super(props);
}

class GetModalityForId extends ModalityEvent {
  final String idString;

  GetModalityForId(this.idString) : super([idString]);
}

class GetForAllModalities extends ModalityEvent {}