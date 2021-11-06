import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_episodes.dart';
import 'package:flutter/foundation.dart';

class TVEpisodeNotifier extends ChangeNotifier {
  var _tvEpisodes = <Episode>[];

  List<Episode> get tvEpisodes => _tvEpisodes;

  var _tvEpisodesState = RequestState.Empty;

  RequestState get tvEpisodesState => _tvEpisodesState;

  String _message = '';

  String get message => _message;

  TVEpisodeNotifier({required this.getTVepisodes});

  final GetTVepisodes getTVepisodes;

  Future<void> fetchTVEpisodes(
      int? tvId, int? seasonNumber, String? seasonName) async {
    _tvEpisodesState = RequestState.Loading;
    notifyListeners();

    final result = await getTVepisodes.execute(tvId, seasonNumber, seasonName);
    result.fold(
      (failure) {
        _tvEpisodesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (episodesData) {
        _tvEpisodesState = RequestState.Loaded;
        _tvEpisodes = episodesData;
        notifyListeners();
      },
    );
  }
}
