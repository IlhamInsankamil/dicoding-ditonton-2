part of 'tv_on_the_air_bloc.dart';

abstract class TvOnTheAirState extends Equatable {
  const TvOnTheAirState();

  @override
  List<Object> get props => [];
}

class TvOnTheAirEmpty extends TvOnTheAirState {}

class TvOnTheAirLoading extends TvOnTheAirState {}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;

  TvOnTheAirError(this.message);

  @override
  List<Object> get props => [message];
}

class TvOnTheAirHasData extends TvOnTheAirState {
  final List<TV> result;

  TvOnTheAirHasData(this.result);

  @override
  List<Object> get props => [result];
}
