import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'mv_top_rated_event.dart';

part 'mv_top_rated_state.dart';

class MvTopRatedBloc extends Bloc<MvTopRatedEvent, MvTopRatedState> {
  final GetTopRatedMovies _topRatedMovies;

  MvTopRatedBloc(this._topRatedMovies) : super(MvTopRatedEmpty());

  @override
  Stream<MvTopRatedState> mapEventToState(
    MvTopRatedEvent event,
  ) async* {
    if (event is LoadTopRated) {
      yield MvTopRatedLoading();
      final resultTopRated = await _topRatedMovies.execute();

      yield* resultTopRated.fold(
        (failure) async* {
          yield MvTopRatedError(failure.message);
        },
        (data) async* {
          yield MvTopRatedHasData(data);
        },
      );
    }
  }
}
