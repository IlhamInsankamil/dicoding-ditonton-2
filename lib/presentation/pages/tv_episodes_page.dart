import 'package:ditonton/presentation/bloc/tv_episode_bloc.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TVEpisodesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-episodes';

  final int? tvId, seasonNumber;
  final String? seasonName;

  TVEpisodesPage(
      {required this.tvId,
      required this.seasonNumber,
      required this.seasonName});

  @override
  _TVEpisodesPageState createState() => _TVEpisodesPageState();
}

class _TVEpisodesPageState extends State<TVEpisodesPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<TvEpisodeBloc>()
        .add(GetEpisode(widget.tvId, widget.seasonNumber, widget.seasonName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.seasonName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvEpisodeBloc, TvEpisodeState>(
          builder: (context, state) {
            if (state is TvEpisodeLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvEpisodeHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = state.result[index];
                  return CustomCard(
                      episode.id,
                      0,
                      episode.episodeNumber.toString(),
                      episode.overview,
                      episode.stillPath,
                      1);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvEpisodeError) {
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
