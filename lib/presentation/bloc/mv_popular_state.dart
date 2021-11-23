part of 'mv_popular_bloc.dart';

abstract class MvPopularState extends Equatable {
  const MvPopularState();

  @override
  List<Object> get props => [];
}

class MvPopularEmpty extends MvPopularState {}

class MvPopularLoading extends MvPopularState {}

class MvPopularError extends MvPopularState {
  final String message;

  MvPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MvPopularHasData extends MvPopularState {
  final List<Movie> result;

  MvPopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
