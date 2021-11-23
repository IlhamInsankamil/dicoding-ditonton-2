part of 'tv_episode_bloc.dart';

abstract class TvEpisodeEvent extends Equatable {
  const TvEpisodeEvent();

  @override
  List<Object> get props => [];
}

class GetEpisode extends TvEpisodeEvent {
  final int? tvId, seasonNumber;
  final String? seasonName;

  GetEpisode(this.tvId, this.seasonNumber, this.seasonName);

  @override
  List<Object> get props => [
        {tvId},
        {seasonNumber},
        {seasonName}
      ];
}
