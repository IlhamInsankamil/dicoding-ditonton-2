import 'package:ditonton/presentation/bloc/mv_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();

    context.read<MvPopularBloc>().add(LoadPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MvPopularBloc, MvPopularState>(
          builder: (context, state) {
            if (state is MvPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MvPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return CustomCard(movie.id, movie.isMovie, movie.title,
                      movie.overview, movie.posterPath, 0);
                },
                itemCount: state.result.length,
              );
            } else if (state is MvPopularError) {
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
