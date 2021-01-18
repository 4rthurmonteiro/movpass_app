import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_all_modalities.dart';
import 'package:flutter_test/flutter_test.dart';

class MockModalityRepository extends Mock implements ModalityRepository {}

void main() {
  GetAllModalities usecase;
  MockModalityRepository mockModalityRepository;

  setUp(() {
    mockModalityRepository = MockModalityRepository();
    usecase = GetAllModalities(mockModalityRepository);
  });

  final tModalityList = [
    Modality(id: 1, label: 'test', description: 'test', duration: 30),
    Modality(id: 2, label: 'test', description: 'test', duration: 78)
  ];

  test(
    'should get all modalities from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getAllModalities is called, always answer with
      // the Right "side" of Either containing a test Modality object.
      when(mockModalityRepository.getAllModalities())
          .thenAnswer((_) async => Right(tModalityList));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(NoParams());
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tModalityList));
      // Verify that the method has been called on the Repository
      verify(mockModalityRepository.getAllModalities());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockModalityRepository);
    },
  );
}
