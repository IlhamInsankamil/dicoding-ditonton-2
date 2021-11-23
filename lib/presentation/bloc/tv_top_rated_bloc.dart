import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTV _topRatedTv;

  TvTopRatedBloc(this._topRatedTv) : super(TvTopRatedEmpty());

  @override
  Stream<TvTopRatedState> mapEventToState(
    TvTopRatedEvent event,
  ) async* {
    if (event is LoadTopRated) {
      yield TvTopRatedLoading();
      final resultTopRated = await _topRatedTv.execute();

      yield* resultTopRated.fold(
        (failure) async* {
          yield TvTopRatedError(failure.message);
        },
        (data) async* {
          yield TvTopRatedHasData(data);
        },
      );
    }
  }
}
