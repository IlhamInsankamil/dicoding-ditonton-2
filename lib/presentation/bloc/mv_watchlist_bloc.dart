import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'mv_watchlist_event.dart';

part 'mv_watchlist_state.dart';

class MvWatchlistBloc extends Bloc<MvWatchlistEvent, MvWatchlistState> {
  final GetWatchlistMovies _watchlistMovies;

  MvWatchlistBloc(this._watchlistMovies) : super(MvWatchlistEmpty());

  @override
  Stream<MvWatchlistState> mapEventToState(
    MvWatchlistEvent event,
  ) async* {
    if (event is LoadWatchlist) {
      yield MvWatchlistLoading();
      final resultWatchlist = await _watchlistMovies.execute();

      yield* resultWatchlist.fold(
        (failure) async* {
          yield MvWatchlistError(failure.message);
        },
        (data) async* {
          yield MvWatchlistHasData(data);
        },
      );
    }
  }
}

class MvWatchlistStatusBloc
    extends Bloc<MvWatchlistEvent, MvWatchlistStatusState> {
  final GetWatchListStatus _watchListStatus;

  MvWatchlistStatusBloc(this._watchListStatus)
      : super(MvWatchlistStatusState(false));

  @override
  Stream<MvWatchlistStatusState> mapEventToState(
    MvWatchlistEvent event,
  ) async* {
    if (event is GetWatchlistStatus) {
      final id = event.id;

      final resultWatchlist = await _watchListStatus.execute(id);

      yield MvWatchlistStatusState(resultWatchlist);
    }
  }
}

class MvWatchlistOperationBloc
    extends Bloc<MvWatchlistEvent, MvWatchlistOperationState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  MvWatchlistOperationBloc(this.saveWatchlist, this.removeWatchlist,
      this.saveWatchlistTV, this.removeWatchlistTV)
      : super(MvWatchlistOperationLoading(''));

  @override
  Stream<MvWatchlistOperationState> mapEventToState(
    MvWatchlistEvent event,
  ) async* {
    if (event is AddToWatchList) {
      yield MvWatchlistOperationLoading('Loading');

      final mv = event.movie;

      final resultWatchlist = await saveWatchlist.execute(mv);

      yield* resultWatchlist.fold(
        (failure) async* {
          yield MvWatchlistSaveError(failure.message);
        },
        (message) async* {
          yield MvWatchlistSaveComplete(message);
        },
      );
    } else if (event is RemoveFromWatchList) {
      yield MvWatchlistOperationLoading('Loading');

      final mv = event.movie;

      final resultWatchlist = await removeWatchlist.execute(mv);

      yield* resultWatchlist.fold(
        (failure) async* {
          yield MvWatchlistRemoveError(failure.message);
        },
        (message) async* {
          yield MvWatchlistRemoveComplete(message);
        },
      );
    } else if (event is AddToWatchListTV) {
      yield MvWatchlistOperationLoading('Loading');

      final tv = event.tv;

      final resultWatchlistTV = await saveWatchlistTV.execute(tv);

      yield* resultWatchlistTV.fold(
        (failure) async* {
          yield MvWatchlistSaveError(failure.message);
        },
        (message) async* {
          yield MvWatchlistSaveComplete(message);
        },
      );
    } else if (event is RemoveFromWatchListTV) {
      yield MvWatchlistOperationLoading('Loading');

      final tv = event.tv;

      final resultWatchlistTV = await removeWatchlistTV.execute(tv);

      yield* resultWatchlistTV.fold(
        (failure) async* {
          yield MvWatchlistRemoveError(failure.message);
        },
        (message) async* {
          yield MvWatchlistRemoveComplete(message);
        },
      );
    }
  }
}
