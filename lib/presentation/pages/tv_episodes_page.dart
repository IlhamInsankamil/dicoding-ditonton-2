import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_episode_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<TVEpisodeNotifier>(context, listen: false).fetchTVEpisodes(
            widget.tvId, widget.seasonNumber, widget.seasonName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.seasonName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TVEpisodeNotifier>(
          builder: (context, data, child) {
            if (data.tvEpisodesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.tvEpisodesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = data.tvEpisodes[index];
                  return CustomCard(
                      episode.id,
                      0,
                      episode.episodeNumber.toString(),
                      episode.overview,
                      episode.stillPath,
                      1);
                },
                itemCount: data.tvEpisodes.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
