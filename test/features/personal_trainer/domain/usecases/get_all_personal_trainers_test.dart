import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/domain/repositories/personal_trainer_repository.dart';
import 'package:movpass_app/features/personal_trainer/domain/usecases/get_all_personal_trainers.dart';

class MockPersonalTrainerRepository extends Mock
    implements PersonalTrainerRepository {}

void main() {
  GetAllPersonalTrainers usecase;
  MockPersonalTrainerRepository mockPersonalTrainerRepository;

  setUp(() {
    mockPersonalTrainerRepository = MockPersonalTrainerRepository();
    usecase = GetAllPersonalTrainers(mockPersonalTrainerRepository);
  });

  final tModalityList = [
    Modality(id: 1, label: 'test', description: 'test', duration: 30),
    Modality(id: 2, label: 'test', description: 'test', duration: 78)
  ];

  final tPersonalTrainers = [
    PersonalTrainer(cref: "1234567-8", email: "jacob@trainer.com", id: 1, modalities: tModalityList, name: "John"),
    PersonalTrainer(cref: "1234567-9", email: "jacob2@trainer.com", id: 2, modalities: tModalityList, name: "John"),
    PersonalTrainer(cref: "1234567-7", email: "jacob3@trainer.com", id: 3, modalities: tModalityList, name: "John"),

  ];

  test(
    'should get all modalities from the repository',
        () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getAllModalities is called, always answer with
      // the Right "side" of Either containing a test Modality object.
      when(mockPersonalTrainerRepository.getAllPersonalTrainers())
          .thenAnswer((_) async => Right(tPersonalTrainers));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(NoParams());
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tPersonalTrainers));
      // Verify that the method has been called on the Repository
      verify(mockPersonalTrainerRepository.getAllPersonalTrainers());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockPersonalTrainerRepository);
    },
  );
}