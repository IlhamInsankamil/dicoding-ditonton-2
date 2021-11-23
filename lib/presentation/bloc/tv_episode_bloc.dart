import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_episodes.dart';
import 'package:equatable/equatable.dart';

part 'tv_episode_event.dart';

part 'tv_episode_state.dart';

class TvEpisodeBloc extends Bloc<TvEpisodeEvent, TvEpisodeState> {
  final GetTVepisodes _episodeTV;

  TvEpisodeBloc(this._episodeTV) : super(TvEpisodeEmpty());

  @override
  Stream<TvEpisodeState> mapEventToState(
    TvEpisodeEvent event,
  ) async* {
    if (event is GetEpisode) {
      final tvId = event.tvId;
      final seasonNumber = event.seasonNumber;
      final seasonName = event.seasonName;

      yield TvEpisodeLoading();
      final result = await _episodeTV.execute(tvId, seasonNumber, seasonName);

      yield* result.fold(
        (failure) async* {
          yield TvEpisodeError(failure.message);
        },
        (data) async* {
          yield TvEpisodeHasData(data);
        },
      );
    }
  }
}
