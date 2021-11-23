part of 'mv_now_playing_bloc.dart';

abstract class MvNowPlayingState extends Equatable {
  const MvNowPlayingState();

  @override
  List<Object> get props => [];
}

class MvNowPlayingEmpty extends MvNowPlayingState {}

class MvNowPlayingLoading extends MvNowPlayingState {}

class MvNowPlayingError extends MvNowPlayingState {
  final String message;

  MvNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MvNowPlayingHasData extends MvNowPlayingState {
  final List<Movie> result;

  MvNowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
