import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_recommendation_event.dart';

part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTVRecommendations _recommendationTV;

  TvRecommendationBloc(this._recommendationTV) : super(TvRecommendationEmpty());

  @override
  Stream<TvRecommendationState> mapEventToState(
    TvRecommendationEvent event,
  ) async* {
    if (event is GetRecommendation) {
      final id = event.id;

      yield TvRecommendationLoading();
      final result = await _recommendationTV.execute(id);

      yield* result.fold(
        (failure) async* {
          yield TvRecommendationError(failure.message);
        },
        (data) async* {
          yield TvRecommendationHasData(data);
        },
      );
    }
  }
}
