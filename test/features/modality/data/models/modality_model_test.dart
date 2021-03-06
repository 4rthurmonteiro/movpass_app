import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  final tModalityModel = ModalityModel(id: 1, label: 'test', description: 'test', duration: 30);

  test(
    'should be a subclass of Mdality entity',
        () async {
      // assert
      expect(tModalityModel, isA<Modality>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('modality.json')) as Map<String, dynamic>;
        // act
        final result = ModalityModel.fromJson(jsonMap);
        // assert
        expect(result, tModalityModel);
      },
    );
  });
}