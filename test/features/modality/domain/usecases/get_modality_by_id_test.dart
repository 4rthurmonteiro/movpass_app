import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_modality_by_id.dart';

class MockModalityRepository extends Mock
    implements ModalityRepository {}

void main() {
  GetModalityById usecase;
  MockModalityRepository mockModalityRepository;

  setUp(() {
    mockModalityRepository = MockModalityRepository();
    usecase = GetModalityById(mockModalityRepository);
  });

  const tId = 1;
  final tModality = Modality(id: 1, label: 'test', description: 'test', duration: 30);

  test(
    'should get modality for the id from the repository',
        () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getModalityById is called with any argument, always answer with
      // the Right "side" of Either containing a test Modality object.
      when(mockModalityRepository.getModalityById(any))
          .thenAnswer((_) async => Right(tModality));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(Params(id: tId));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tModality));
      // Verify that the method has been called on the Repository
      verify(mockModalityRepository.getModalityById(tId));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockModalityRepository);
    },
  );
}