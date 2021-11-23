import 'package:ditonton/presentation/bloc/mv_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    context.read<MvTopRatedBloc>().add(LoadTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MvTopRatedBloc, MvTopRatedState>(
          builder: (context, state) {
            if (state is MvTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MvTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return CustomCard(movie.id, movie.isMovie, movie.title,
                      movie.overview, movie.posterPath, 0);
                },
                itemCount: state.result.length,
              );
            } else if (state is MvTopRatedError) {
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
