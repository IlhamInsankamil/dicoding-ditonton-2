import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getTVonTheAir();

  Future<Either<Failure, List<TV>>> getPopularTV();

  Future<Either<Failure, List<TV>>> getTopRatedTV();

  Future<Either<Failure, TVDetail>> getTVDetail(int id);

  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);

  Future<Either<Failure, List<TV>>> searchTV(String query);

  Future<Either<Failure, String>> saveWatchlistTV(TVDetail movie);

  Future<Either<Failure, String>> removeWatchlistTV(TVDetail movie);

  Future<Either<Failure, List<Episode>>> getEpisodes(
      int tvId, int seasonNumber);
}
