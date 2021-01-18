import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';
import 'package:meta/meta.dart';

class GetAllModalities extends UseCase<List<Modality>, NoParams> {
  final ModalityRepository repository;

  GetAllModalities(this.repository);

  @override
  Future<Either<Failure, List<Modality>>> call(NoParams params) async {
    return repository.getAllModalities();
  }
}
