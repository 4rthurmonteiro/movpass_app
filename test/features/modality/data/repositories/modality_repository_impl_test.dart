import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/network/network_info.dart';
import 'package:movpass_app/features/modality/data/datasources/modality_local_data_source.dart';
import 'package:movpass_app/features/modality/data/datasources/modality_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/modality/data/repositories/modality_repository_impl.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

class MockRemoteDataSource extends Mock implements ModalityRemoteDataSource {}

class MockLocalDataSource extends Mock implements ModalityLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ModalityRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ModalityRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getModalityById', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    const tId = 1;

    final tModalityModel = ModalityModel(
        id: tId, label: 'test', description: 'test', duration: 30);

    final Modality tModality = tModalityModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getModalityById(tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getModalityById(tId))
              .thenAnswer((_) async => tModalityModel);
          // act
          final result = await repository.getModalityById(tId);
          // assert
          verify(mockRemoteDataSource.getModalityById(tId));
          expect(result, equals(Right(tModality)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getModalityById(tId))
              .thenAnswer((_) async => tModalityModel);
          // act
          await repository.getModalityById(tId);
          // assert
          verify(mockRemoteDataSource.getModalityById(tId));
          verify(mockLocalDataSource.cacheModality(tModality as ModalityModel));
        },
      );
      //
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getModalityById(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getModalityById(tId);
          // assert
          verify(mockRemoteDataSource.getModalityById(tId));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return  locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getModalityById(tId))
              .thenAnswer((_) async => tModalityModel);
          // act
          final result = await repository.getModalityById(tId);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getModalityById(tId));
          expect(result, equals(Right(tModality)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getModalityById(tId))
              .thenThrow(CacheException());
          // act
          final result = await repository.getModalityById(tId);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getModalityById(tId));
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getAllModalities', () {
    const tId = 1;
    const tId2 = 2;

    final tModalityModel = ModalityModel(
        id: tId, label: 'test', description: 'test', duration: 30);
    final tModalityModel2 = ModalityModel(
        id: tId2, label: 'test', description: 'test', duration: 78);
    final Modality tModality = tModalityModel;
    final tModalityModelList = [tModalityModel, tModalityModel2];
    final List<Modality> tModalityList = tModalityModelList;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getAllModalities();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getAllModalities())
              .thenAnswer((_) async => tModalityModelList);

          final result = await repository.getAllModalities();

          verify(mockRemoteDataSource.getAllModalities());
          expect(result, equals(Right(tModalityList)));
        },
      );

      test(
        'should cache the data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getAllModalities())
              .thenAnswer((_) async => tModalityModelList);

          final result = await repository.getAllModalities();

          verify(mockRemoteDataSource.getAllModalities());
          verify(mockLocalDataSource
              .cacheModalities(tModalityList as List<ModalityModel>));
        },
      );

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getAllModalities())
            .thenThrow(ServerException());

        final result = await repository.getAllModalities();

        verify(mockRemoteDataSource.getAllModalities());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return all modalities locally cached data when the cached data is present',
          () async {
            when(mockLocalDataSource.getAllModalities())
                .thenAnswer((_) async  => tModalityModelList);

            final result = await repository.getAllModalities();

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getAllModalities());
            expect(result, equals(Right(tModalityList)));


          });

      test(
          'should return all CacheFailure when there is no cached data present',
              () async {
            when(mockLocalDataSource.getAllModalities())
                .thenThrow(CacheException());

            final result = await repository.getAllModalities();

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getAllModalities());
            expect(result, equals(Left(CacheFailure())));
          });
    });
  });
}
