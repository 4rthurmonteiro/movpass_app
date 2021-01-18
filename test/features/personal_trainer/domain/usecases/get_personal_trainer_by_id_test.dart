import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/domain/repositories/personal_trainer_repository.dart';
import 'package:movpass_app/features/personal_trainer/domain/usecases/get_personal_trainer_by_id.dart';

class MockPersonalTrainerRepository extends Mock
    implements PersonalTrainerRepository {}

void main() {
  GetPersonalTrainerById usecase;
  MockPersonalTrainerRepository mockPersonalTrainerRepository;

  setUp(() {
    mockPersonalTrainerRepository = MockPersonalTrainerRepository();
    usecase = GetPersonalTrainerById(mockPersonalTrainerRepository);
  });

  const tId = 1;

  final tModalityList = [
    ModalityModel(id: 1, label: 'test', description: 'test', duration: 30),
    ModalityModel(id: 2, label: 'test', description: 'test', duration: 78)
  ];

  final tPersonalTrainer = PersonalTrainer(cref: "1234567-8", email: "jacob@trainer.com", id: 1, modalities: tModalityList, name: "John");

  test(
    'should get personal trainer for the id from the repository',
        () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getPersonalTrainerById is called with any argument, always answer with
      // the Right "side" of Either containing a test PersonalTrainer object.
      when(mockPersonalTrainerRepository.getPersonalTrainerById(any))
          .thenAnswer((_) async => Right(tPersonalTrainer));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(Params(id: tId));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tPersonalTrainer));
      // Verify that the method has been called on the Repository
      verify(mockPersonalTrainerRepository.getPersonalTrainerById(tId));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockPersonalTrainerRepository);
    },
  );
}