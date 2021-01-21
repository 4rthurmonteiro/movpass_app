import 'package:dartz/dartz.dart';
import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/network/network_info.dart';
import 'package:movpass_app/features/personal_trainer/data/datasources/personal_trainer_local_data_source.dart';
import 'package:movpass_app/features/personal_trainer/data/datasources/personal_trainer_remote_data_source.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/domain/repositories/personal_trainer_repository.dart';
import 'package:meta/meta.dart';

class PersonalTrainerRepositoryImpl implements PersonalTrainerRepository {
  final PersonalTrainerRemoteDataSource remoteDataSource;
  final PersonalTrainerLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonalTrainerRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, List<PersonalTrainer>>> getAllPersonalTrainers() async {
    if(await networkInfo.isConnected){
     try {
       final remotePersonalTrainers = await remoteDataSource.getAllPersonalTrainers();
       localDataSource.cachePersonalTrainers(remotePersonalTrainers);
       return Right(remotePersonalTrainers);
     } on ServerException {
       return Left(ServerFailure());
     }
    }else {
      try {
        final localPersonalTrainers = await localDataSource.getAllPersonalTrainers();
        return Right(localPersonalTrainers);
      } on CacheException {
        return Left(CacheFailure());
    }

    }
  }

  @override
  Future<Either<Failure, PersonalTrainer>> getPersonalTrainerById(int id) async {
    if(await networkInfo.isConnected) {
      try {
        final remotePersonalTrainer = await remoteDataSource.getPersonalTrainerById(id);
        localDataSource.cachePersonalTrainer(remotePersonalTrainer);
        return Right(remotePersonalTrainer);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPersonalTrainer = await localDataSource.getPersonalTrainerById(id);
        return Right(localPersonalTrainer);
      } on CacheException {
        return Left(CacheFailure());
      }
    }

  }

}