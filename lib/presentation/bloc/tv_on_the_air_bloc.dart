import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:equatable/equatable.dart';

part 'tv_on_the_air_event.dart';

part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetTVonTheAir _onTheAirTV;

  TvOnTheAirBloc(this._onTheAirTV) : super(TvOnTheAirEmpty());

  @override
  Stream<TvOnTheAirState> mapEventToState(
    TvOnTheAirEvent event,
  ) async* {
    if (event is LoadOnTheAir) {
      yield TvOnTheAirLoading();
      final resultOnTheAir = await _onTheAirTV.execute();

      yield* resultOnTheAir.fold(
        (failure) async* {
          yield TvOnTheAirError(failure.message);
        },
        (data) async* {
          yield TvOnTheAirHasData(data);
        },
      );
    }
  }
}
