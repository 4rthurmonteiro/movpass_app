import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/features/modality/data/datasources/modality_remote_data_source.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'package:matcher/matcher.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ModalityRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ModalityRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String name) {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('$name.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getModalityById', () {
    const tId = 1;
    final tModalityModel = ModalityModel(
        id: tId, label: 'test', description: 'test', duration: 30);

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200('modality');
        // act
        dataSource.getModalityById(tId);
        // assert
        verify(mockHttpClient.get(
          'https://dev.movpass.com.br/api/modalities/$tId',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return Modality when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('modality');
        // act
        final result = await dataSource.getModalityById(tId);
        // assert
        expect(result, equals(tModalityModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getModalityById;
        // assert
        expect(() => call(tId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getAllModalities', () {
    const tId = 1;
    const tId2 = 2;

    final tModalityModel = ModalityModel(
        id: tId, label: 'test', description: 'test', duration: 30);
    final tModalityModel2 = ModalityModel(
        id: tId2, label: 'test', description: 'test', duration: 78);
    final Modality tModality = tModalityModel;
    final tModalityModelList = [tModalityModel, tModalityModel2, tModalityModel, tModalityModel2];
    final List<Modality> tModalityList = tModalityModelList;

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
          () {
        //arrange
        setUpMockHttpClientSuccess200('modalities');
        // act
        dataSource.getAllModalities();
        // assert
        verify(mockHttpClient.get(
          'https://dev.movpass.com.br/api/modalities',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return Modality List when the response code is 200 (success)',
          () async {
        // arrange
        setUpMockHttpClientSuccess200('modalities');
        // act
        final result = await dataSource.getAllModalities();
        // assert
        expect(result.isNotEmpty, equals(tModalityModelList.isNotEmpty));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getModalityById;
        // assert
        expect(() => call(tId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
