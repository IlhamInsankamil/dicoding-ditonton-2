import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'mv_recommendation_event.dart';

part 'mv_recommendation_state.dart';

class MvRecommendationBloc
    extends Bloc<MvRecommendationEvent, MvRecommendationState> {
  final GetMovieRecommendations _recommendationMovie;

  MvRecommendationBloc(this._recommendationMovie)
      : super(MvRecommendationEmpty());

  @override
  Stream<MvRecommendationState> mapEventToState(
    MvRecommendationEvent event,
  ) async* {
    if (event is GetRecommendation) {
      final id = event.id;

      yield MvRecommendationLoading();
      final result = await _recommendationMovie.execute(id);

      yield* result.fold(
        (failure) async* {
          yield MvRecommendationError(failure.message);
        },
        (data) async* {
          yield MvRecommendationHasData(data);
        },
      );
    }
  }
}
