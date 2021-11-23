import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'mv_now_playing_event.dart';

part 'mv_now_playing_state.dart';

class MvNowPlayingBloc extends Bloc<MvNowPlayingEvent, MvNowPlayingState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  MvNowPlayingBloc(this._nowPlayingMovies) : super(MvNowPlayingEmpty());

  @override
  Stream<MvNowPlayingState> mapEventToState(
    MvNowPlayingEvent event,
  ) async* {
    if (event is LoadNowPlaying) {
      yield MvNowPlayingLoading();
      final resultNowPlaying = await _nowPlayingMovies.execute();

      yield* resultNowPlaying.fold(
        (failure) async* {
          yield MvNowPlayingError(failure.message);
        },
        (data) async* {
          yield MvNowPlayingHasData(data);
        },
      );
    }
  }
}
