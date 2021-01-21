import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/core/utils/input_converter.dart';
import 'package:meta/meta.dart';
import 'package:movpass_app/features/personal_trainer/domain/usecases/get_all_personal_trainers.dart';
import 'package:movpass_app/features/personal_trainer/domain/usecases/get_personal_trainer_by_id.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class
PersonalTrainerBloc extends Bloc<PersonalTrainerEvent, PersonalTrainerState> {
  final GetAllPersonalTrainers getAllPersonalTrainers;
  final GetPersonalTrainerById getPersonalTrainerById;
  final InputConverter inputConverter;

  PersonalTrainerBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetAllPersonalTrainers personalTrainers,
    @required GetPersonalTrainerById personalTrainer,
    @required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(personalTrainers != null),
        assert(personalTrainer != null),
        assert(inputConverter != null),
        getAllPersonalTrainers = personalTrainers,
        getPersonalTrainerById = personalTrainer;

  @override
  PersonalTrainerState get initialState => Empty();

  @override
  Stream<PersonalTrainerState> mapEventToState(
    PersonalTrainerEvent event,
  ) async* {
    if (event is GetPersonalTrainerForId) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.idString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrPersonalTrainer = await getPersonalTrainerById(
            Params(id: integer),
          );
          yield failureOrPersonalTrainer.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (personalTrainer) => Loaded(personalTrainer: personalTrainer),
          );
        },
      );
    } else if (event is GetForAllPersonalTrainers){
      yield Loading();
      final failureOrPersonalTrainers = await getAllPersonalTrainers(
        NoParams(),
      );
      yield failureOrPersonalTrainers.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (personalTrainers) => LoadedAll(personalTrainers: personalTrainers)
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
