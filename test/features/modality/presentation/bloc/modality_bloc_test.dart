import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/core/utils/input_converter.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_all_modalities.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_modality_by_id.dart';
import 'package:movpass_app/features/modality/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetModalityById extends Mock implements GetModalityById {}

class MockGetAllModalities extends Mock implements GetAllModalities {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  ModalityBloc bloc;
  MockGetModalityById mockGetModalityById;
  MockGetAllModalities mockGetAllModalities;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetModalityById = MockGetModalityById();
    mockGetAllModalities = MockGetAllModalities();
    mockInputConverter = MockInputConverter();

    bloc = ModalityBloc(
        modalities: mockGetAllModalities,
        modality: mockGetModalityById,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetModalityForId', () {
    // The event takes in a String
    const tIdString = '1';
    // This is the successful output of the InputConverter
    final tIdParsed = int.parse(tIdString);
    // NumberTrivia instance is needed too, of course
    final tModality =
        Modality(id: 1, label: 'test', description: 'test', duration: 30);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tIdParsed));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        // act
        bloc.dispatch(GetModalityForId(tIdString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tIdString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          // The initial state is always emitted first
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetModalityForId(tIdString));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();

        when(mockGetModalityById(any))
            .thenAnswer((_) async => Right(tModality));
        // act
        bloc.dispatch(GetModalityForId(tIdString));
        await untilCalled(mockGetModalityById(any));
        // assert
        verify(mockGetModalityById(Params(id: tIdParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetModalityById(any))
            .thenAnswer((_) async => Right(tModality));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(modality: tModality),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetModalityForId(tIdString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetModalityById(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetModalityForId(tIdString));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetModalityById(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetModalityForId(tIdString));
      },
    );
  });

  group('GetForAllModalities', () {
    final tModalities = [
      Modality(id: 1, label: 'test', description: 'test', duration: 30)
    ];

    test(
      'should get data from the all use case',
          () async {
        // arrange
        when(mockGetAllModalities(any))
            .thenAnswer((_) async => Right(tModalities));
        // act
        bloc.dispatch(GetForAllModalities());
        await untilCalled(mockGetAllModalities(any));
        // assert
        verify(mockGetAllModalities(NoParams()));
      },
    );

    test(
      'should emit [Loading, LoadedAll] when data is gotten successfully',
          () async {
        // arrange
        when(mockGetAllModalities(any))
            .thenAnswer((_) async => Right(tModalities));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          LoadedAll(modalities: tModalities),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetForAllModalities());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
          () async {
        // arrange
        when(mockGetAllModalities(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetForAllModalities());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
          () async {
        // arrange
        when(mockGetAllModalities(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetForAllModalities());
      },
    );
  });
}
