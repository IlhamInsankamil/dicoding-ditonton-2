import 'package:ditonton/presentation/bloc/mv_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();

    context.read<MvWatchlistBloc>().add(LoadWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MvWatchlistBloc, MvWatchlistState>(
          builder: (context, state) {
            if (state is MvWatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MvWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return CustomCard(movie.id, movie.isMovie, movie.title,
                      movie.overview, movie.posterPath, 0);
                },
                itemCount: state.result.length,
              );
            } else if (state is MvWatchlistError) {
              return Text(state.message);
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
