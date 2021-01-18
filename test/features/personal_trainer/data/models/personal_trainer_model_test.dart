import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/personal_trainer/data/models/personal_trainer_model.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';

import '../../../../fixtures/fixture_reader.dart';

final tModalityList = [
  ModalityModel(id: 1, label: 'test', description: 'test', duration: 30),
  ModalityModel(id: 2, label: 'test', description: 'test', duration: 78)
];

void main() {
  final tPersonalTrainerModel = PersonalTrainerModel(cref: "1234567-8", email: "jacob@trainer.com", id: 1, modalities: tModalityList, name: "John");

  test(
    'should be a subclass of PersonalTrainer entity',
        () async {
      // assert
      expect(tPersonalTrainerModel, isA<PersonalTrainer>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('personal_trainer.json')) as Map<String, dynamic>;
        // act
        final result = PersonalTrainerModel.fromJson(jsonMap);
        // assert
        expect(result, tPersonalTrainerModel);
      },
    );
  });
}