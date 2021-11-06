import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  final String? airDate;
  final int? episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final List<Episode>? episodes;

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        episodes,
      ];
}
