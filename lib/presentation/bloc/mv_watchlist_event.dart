part of 'mv_watchlist_bloc.dart';

abstract class MvWatchlistEvent extends Equatable {
  const MvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlist extends MvWatchlistEvent {
  @override
  List<Object> get props => [];
}

class AddToWatchList extends MvWatchlistEvent {
  final MovieDetail movie;

  AddToWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchList extends MvWatchlistEvent {
  final MovieDetail movie;

  RemoveFromWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class GetWatchlistStatus extends MvWatchlistEvent {
  final int id;

  GetWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchListTV extends MvWatchlistEvent {
  final TVDetail tv;

  AddToWatchListTV(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchListTV extends MvWatchlistEvent {
  final TVDetail tv;

  RemoveFromWatchListTV(this.tv);

  @override
  List<Object> get props => [tv];
}
