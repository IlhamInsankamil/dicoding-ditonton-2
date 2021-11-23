part of 'mv_watchlist_bloc.dart';

abstract class MvWatchlistState extends Equatable {
  const MvWatchlistState();

  @override
  List<Object> get props => [];
}

class MvWatchlistEmpty extends MvWatchlistState {}

class MvWatchlistLoading extends MvWatchlistState {}

class MvWatchlistError extends MvWatchlistState {
  final String message;

  MvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MvWatchlistHasData extends MvWatchlistState {
  final List<Movie> result;

  MvWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MvWatchlistStatusState extends Equatable {
  bool isAddedToWatchlist = false;

  MvWatchlistStatusState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

abstract class MvWatchlistOperationState extends Equatable {
  final String message;

  MvWatchlistOperationState(this.message);

  @override
  List<Object> get props => [message];
}

class MvWatchlistOperationLoading extends MvWatchlistOperationState {
  MvWatchlistOperationLoading(String message) : super(message);
}

class MvWatchlistSaveError extends MvWatchlistOperationState {
  final String message;

  MvWatchlistSaveError(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class MvWatchlistSaveComplete extends MvWatchlistOperationState {
  final String message;

  MvWatchlistSaveComplete(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class MvWatchlistRemoveError extends MvWatchlistOperationState {
  final String message;

  MvWatchlistRemoveError(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class MvWatchlistRemoveComplete extends MvWatchlistOperationState {
  final String message;

  MvWatchlistRemoveComplete(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class TvWatchlistSaveError extends MvWatchlistOperationState {
  final String message;

  TvWatchlistSaveError(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class TvWatchlistSaveComplete extends MvWatchlistOperationState {
  final String message;

  TvWatchlistSaveComplete(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class TvWatchlistRemoveError extends MvWatchlistOperationState {
  final String message;

  TvWatchlistRemoveError(this.message) : super('');

  @override
  List<Object> get props => [message];
}

class TvWatchlistRemoveComplete extends MvWatchlistOperationState {
  final String message;

  TvWatchlistRemoveComplete(this.message) : super('');

  @override
  List<Object> get props => [message];
}
