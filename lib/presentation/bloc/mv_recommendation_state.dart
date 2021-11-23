part of 'mv_recommendation_bloc.dart';

abstract class MvRecommendationState extends Equatable {
  const MvRecommendationState();

  @override
  List<Object> get props => [];
}

class MvRecommendationEmpty extends MvRecommendationState {}

class MvRecommendationLoading extends MvRecommendationState {}

class MvRecommendationError extends MvRecommendationState {
  final String message;

  MvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MvRecommendationHasData extends MvRecommendationState {
  final List<Movie> result;

  MvRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
