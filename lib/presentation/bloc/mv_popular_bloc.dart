import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'mv_popular_event.dart';

part 'mv_popular_state.dart';

class MvPopularBloc extends Bloc<MvPopularEvent, MvPopularState> {
  final GetPopularMovies _popularMovies;

  MvPopularBloc(this._popularMovies) : super(MvPopularEmpty());

  @override
  Stream<MvPopularState> mapEventToState(
    MvPopularEvent event,
  ) async* {
    if (event is LoadPopular) {
      yield MvPopularLoading();
      final resultPopular = await _popularMovies.execute();

      yield* resultPopular.fold(
        (failure) async* {
          yield MvPopularError(failure.message);
        },
        (data) async* {
          yield MvPopularHasData(data);
        },
      );
    }
  }
}
