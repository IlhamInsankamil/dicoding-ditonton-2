import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
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
  final List<EpisodeModel>? episodes;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        seasonNumber: json["season_number"],
        episodes: json["episodes"] == null
            ? null
            : List<EpisodeModel>.from(
                json["episodes"].map((x) => EpisodeModel.fromJson(x))),
      );

  Season toEntity() {
    return Season(
      airDate: this.airDate,
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
      episodes: this.episodes == null
          ? null
          : this.episodes!.map((episodes) => episodes.toEntity()).toList(),
    );
  }

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
