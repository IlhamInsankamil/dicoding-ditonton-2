import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail _detailTV;

  TvDetailBloc(this._detailTV) : super(TvDetailEmpty());

  @override
  Stream<TvDetailState> mapEventToState(
    TvDetailEvent event,
  ) async* {
    if (event is GetDetail) {
      final id = event.id;

      yield TvDetailLoading();
      final result = await _detailTV.execute(id);

      yield* result.fold(
        (failure) async* {
          yield TvDetailError(failure.message);
        },
        (data) async* {
          yield TvDetailHasData(data);
        },
      );
    }
  }
}
