import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'mv_detail_event.dart';
part 'mv_detail_state.dart';

class MvDetailBloc extends Bloc<MvDetailEvent, MvDetailState> {
  final GetMovieDetail _detailMovie;

  MvDetailBloc(this._detailMovie) : super(MvDetailEmpty());

  @override
  Stream<MvDetailState> mapEventToState(
      MvDetailEvent event,
      ) async* {
    if (event is GetDetail) {
      final id = event.id;

      yield MvDetailLoading();
      final result = await _detailMovie.execute(id);

      yield* result.fold(
            (failure) async* {
          yield MvDetailError(failure.message);
        },
            (data) async* {
          yield MvDetailHasData(data);
        },
      );
    }
  }
}
