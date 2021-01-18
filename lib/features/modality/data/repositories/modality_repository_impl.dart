import 'package:dartz/dartz.dart';
import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/network/network_info.dart';
import 'package:movpass_app/features/modality/data/datasources/modality_local_data_source.dart';
import 'package:movpass_app/features/modality/data/datasources/modality_remote_data_source.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';
import 'package:meta/meta.dart';

class ModalityRepositoryImpl implements ModalityRepository {
  final ModalityRemoteDataSource remoteDataSource;
  final ModalityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ModalityRepositoryImpl({
      @required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo
  });

  @override
  Future<Either<Failure, List<Modality>>> getAllModalities() async {
    if(await networkInfo.isConnected){
      try {
        final remoteModalities = await remoteDataSource.getAllModalities();
        localDataSource.cacheModalities(remoteModalities);
        return Right(remoteModalities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
        final localModalities = await localDataSource.getAllModalities();
        return Right(localModalities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }

  }

  @override
  Future<Either<Failure, Modality>> getModalityById(int id) async {
    if(await networkInfo.isConnected) {
      try {
        final remoteModality = await remoteDataSource.getModalityById(id);
        localDataSource.cacheModality(remoteModality);
        return Right(remoteModality);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
        final localModality = await localDataSource.getModalityById(id);
        return Right(localModality);
      } on CacheException {
        return Left(CacheFailure());
      }

    }


  }

}