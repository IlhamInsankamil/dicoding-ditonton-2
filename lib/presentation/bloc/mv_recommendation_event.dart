part of 'mv_recommendation_bloc.dart';

abstract class MvRecommendationEvent extends Equatable {
  const MvRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendation extends MvRecommendationEvent {
  final int id;

  GetRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
