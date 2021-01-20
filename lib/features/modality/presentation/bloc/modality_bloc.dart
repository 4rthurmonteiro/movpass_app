import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/core/utils/input_converter.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_all_modalities.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_modality_by_id.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class ModalityBloc extends Bloc<ModalityEvent, ModalityState> {
  final GetAllModalities getAllModalities;
  final GetModalityById getModalityId;
  final InputConverter inputConverter;

  ModalityBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetAllModalities modalities,
    @required GetModalityById modality,
    @required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(modalities != null),
        assert(modality != null),
        assert(inputConverter != null),
        getAllModalities = modalities,
        getModalityId = modality;

  @override
  ModalityState get initialState => Empty();

  @override
  Stream<ModalityState> mapEventToState(
    ModalityEvent event,
  ) async* {
    if (event is GetModalityForId) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.idString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrModality = await getModalityId(
            Params(id: integer),
          );
          yield failureOrModality.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (modality) => Loaded(modality: modality),
          );
        },
      );
    } else if (event is GetForAllModalities){
      yield Loading();
      final failureOrModalities = await getAllModalities(
        NoParams(),
      );
      yield failureOrModalities.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (modalities) => LoadedAll(modalities: modalities)
      );
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
