import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movpass_app/core/error/failure.dart';
import 'package:movpass_app/core/usecases/usecase.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';
import 'package:meta/meta.dart';

class GetModalityById extends UseCase<Modality, Params> {
  final ModalityRepository repository;

  GetModalityById(this.repository);

  @override
  Future<Either<Failure, Modality>> call(Params params) async {
    return repository.getModalityById(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id}) : super([id]);
}
