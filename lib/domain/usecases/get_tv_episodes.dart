import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVepisodes {
  final TVRepository repository;

  GetTVepisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(
      tvId, seasonNumber, seasonName) {
    return repository.getEpisodes(tvId, seasonNumber);
  }
}
