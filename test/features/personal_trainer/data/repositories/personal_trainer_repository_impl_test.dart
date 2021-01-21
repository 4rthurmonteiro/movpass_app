
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/network/network_info.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:movpass_app/features/personal_trainer/data/datasources/personal_trainer_local_data_source.dart';
import 'package:movpass_app/features/personal_trainer/data/datasources/personal_trainer_remote_data_source.dart';
import 'package:movpass_app/features/personal_trainer/data/models/personal_trainer_model.dart';
import 'package:movpass_app/features/personal_trainer/data/repositories/personal_trainer_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';

class MockRemoteDataSource extends Mock
    implements PersonalTrainerRemoteDataSource {}

class MockLocalDataSource extends Mock implements PersonalTrainerLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PersonalTrainerRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PersonalTrainerRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tModalityList = [
    ModalityModel(id: 1, label: 'test', description: 'test', duration: 30),
    ModalityModel(id: 2, label: 'test', description: 'test', duration: 78)
  ];

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


  group('getPersonalTrainerById', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    const tId = 1;
    final tPersonalTrainerModel =
    PersonalTrainerModel(cref: "1234567-8", email: "jacob@trainer.com", id: 1, modalities: tModalityList, name: "John");

    final PersonalTrainer tPersonalTrainer = tPersonalTrainerModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getPersonalTrainerById(tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPersonalTrainerById(tId))
              .thenAnswer((_) async => tPersonalTrainerModel);
          // act
          final result = await repository.getPersonalTrainerById(tId);
          // assert
          verify(mockRemoteDataSource.getPersonalTrainerById(tId));
          expect(result, equals(Right(tPersonalTrainerModel)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPersonalTrainerById(tId))
              .thenAnswer((_) async => tPersonalTrainerModel);
          // act
          await repository.getPersonalTrainerById(tId);
          // assert
          verify(mockRemoteDataSource.getPersonalTrainerById(tId));
          verify(mockLocalDataSource.cachePersonalTrainer(tPersonalTrainer as PersonalTrainerModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPersonalTrainerById(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getPersonalTrainerById(tId);
          // assert
          verify(mockRemoteDataSource.getPersonalTrainerById(tId));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return all personal trainers locally cached data when the cached data is present',
            () async {
          // arrange
          when(mockLocalDataSource.getPersonalTrainerById(tId))
              .thenAnswer((_) async => tPersonalTrainerModel);
          // act
          final result = await repository.getPersonalTrainerById(tId);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getPersonalTrainerById(tId));
          expect(result, equals(Right(tPersonalTrainer
          )));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
            () async {
          // arrange
          when(mockLocalDataSource.getPersonalTrainerById(tId))
              .thenThrow(CacheException());
          // act
          final result = await repository.getPersonalTrainerById(tId);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getPersonalTrainerById(tId));
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getAllPersonalTrainers', () {
    const tId = 1;
    const tId2 = 2;
    final tPersonalTrainerModel =
    PersonalTrainerModel(cref: "1234567-8", email: "jacob@trainer.com", id: 1, modalities: tModalityList, name: "John");
    final tPersonalTrainerModel2 =
    PersonalTrainerModel(cref: "1234567-8", email: "jacob@trainer.com", id: 2, modalities: tModalityList, name: "John");

    final PersonalTrainer tPersonalTrainer = tPersonalTrainerModel;
    final tPersonalTrainerModelList = [tPersonalTrainerModel, tPersonalTrainerModel];
    final List<PersonalTrainer> tPersonalTrainerList = tPersonalTrainerModelList;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getAllPersonalTrainers();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          when(mockRemoteDataSource.getAllPersonalTrainers())
              .thenAnswer((_) async => tPersonalTrainerModelList);

          final result = await repository.getAllPersonalTrainers();

          verify(mockRemoteDataSource.getAllPersonalTrainers());
          expect(result, equals(Right(tPersonalTrainerList)));
        },
      );

      test(
        'should cache the data when the call to remote data source is successful',
            () async {
          when(mockRemoteDataSource.getAllPersonalTrainers())
              .thenAnswer((_) async => tPersonalTrainerModelList);

          final result = await repository.getAllPersonalTrainers();

          verify(mockRemoteDataSource.getAllPersonalTrainers());
          verify(mockLocalDataSource
              .cachePersonalTrainers(tPersonalTrainerList as List<PersonalTrainerModel>));
        },
      );

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            when(mockRemoteDataSource.getAllPersonalTrainers())
                .thenThrow(ServerException());

            final result = await repository.getAllPersonalTrainers();

            verify(mockRemoteDataSource.getAllPersonalTrainers());
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    runTestsOffline(() {
      // test(
      //     'should return all modalities locally cached data when the cached data is present',
      //         () async {
      //       when(mockLocalDataSource.getAllPersonalTrainers())
      //           .thenAnswer((_) async  => tPersonalTrainerModelList);
      //
      //       final result = await repository.getAllPersonalTrainers();
      //
      //       verifyZeroInteractions(mockRemoteDataSource);
      //       // verify(mockLocalDataSource.getAllPersonalTrainers());
      //       expect(result, equals(Right(tPersonalTrainerList)));
      //
      //
      //     });

      // test(
      //     'should return all CacheFailure when there is no cached data present',
      //         () async {
      //       when(mockLocalDataSource.getAllModalities())
      //           .thenThrow(CacheException());
      //
      //       final result = await repository.getAllModalities();
      //
      //       verifyZeroInteractions(mockRemoteDataSource);
      //       verify(mockLocalDataSource.getAllModalities());
      //       expect(result, equals(Left(CacheFailure())));
      //     });
    });
  });

}