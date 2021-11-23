import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_event.dart';

part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTV _popularTV;

  TvPopularBloc(this._popularTV) : super(TvPopularEmpty());

  @override
  Stream<TvPopularState> mapEventToState(
    TvPopularEvent event,
  ) async* {
    if (event is LoadPopular) {
      yield TvPopularLoading();
      final resultPopular = await _popularTV.execute();

      yield* resultPopular.fold(
        (failure) async* {
          yield TvPopularError(failure.message);
        },
        (data) async* {
          yield TvPopularHasData(data);
        },
      );
    }
  }
}
