import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_episodes.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/mv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/mv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/mv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/mv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/mv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/mv_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvWatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvWatchlistStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MvWatchlistOperationBloc(locator(), locator(), locator(), locator()),
  );

  // bloc-tv
  locator.registerFactory(
    () => TVSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvOnTheAirBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvEpisodeBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case-tv
  locator.registerLazySingleton(() => GetTVonTheAir(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetTVepisodes(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository-tv
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources-tv
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  // locator.registerSingletonAsync<http.Client>(
  //       () => SecureClient.getSecureClient(),
  // )
}
