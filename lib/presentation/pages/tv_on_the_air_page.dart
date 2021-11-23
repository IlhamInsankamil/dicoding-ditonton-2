import 'package:ditonton/presentation/bloc/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TVOnTheAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-on-the-air';

  @override
  _TVOnTheAirPageState createState() => _TVOnTheAirPageState();
}

class _TVOnTheAirPageState extends State<TVOnTheAirPage> {
  @override
  void initState() {
    super.initState();

    context.read<TvOnTheAirBloc>().add(LoadOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
          builder: (context, state) {
            if (state is TvOnTheAirLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvOnTheAirHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return CustomCard(tv.id, tv.isMovie, tv.name, tv.overview,
                      tv.posterPath, 0);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvOnTheAirError) {
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
