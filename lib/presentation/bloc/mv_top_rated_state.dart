part of 'mv_top_rated_bloc.dart';

abstract class MvTopRatedState extends Equatable {
  const MvTopRatedState();

  @override
  List<Object> get props => [];
}

class MvTopRatedEmpty extends MvTopRatedState {}

class MvTopRatedLoading extends MvTopRatedState {}

class MvTopRatedError extends MvTopRatedState {
  final String message;

  MvTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MvTopRatedHasData extends MvTopRatedState {
  final List<Movie> result;

  MvTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
