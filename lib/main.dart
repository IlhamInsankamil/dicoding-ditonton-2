import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart' as di;
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
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_page_tv.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_episodes_page.dart';
import 'package:ditonton/presentation/pages/tv_on_the_air_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MvNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MvWatchlistOperationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvEpisodeBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case HomeTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TVOnTheAirPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TVOnTheAirPage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SearchPageTV.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTV());
            case TVEpisodesPage.ROUTE_NAME:
              final dataEps = settings.arguments as Map<String, dynamic>;
              final tvId = dataEps['tvId'] as int?;
              final seasonNumber = dataEps['seasonNumber'] as int?;
              final seasonName = dataEps['seasonName'] as String?;
              return MaterialPageRoute(
                builder: (_) => TVEpisodesPage(
                  tvId: tvId,
                  seasonNumber: seasonNumber,
                  seasonName: seasonName,
                ),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
