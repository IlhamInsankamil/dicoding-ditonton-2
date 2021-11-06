import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVonTheAir {
  final TVRepository repository;

  GetTVonTheAir(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTVonTheAir();
  }
}
