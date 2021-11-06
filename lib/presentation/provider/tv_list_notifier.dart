import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _tvOnTheAir = <TV>[];

  List<TV> get tvOnTheAir => _tvOnTheAir;

  RequestState _onTheAirState = RequestState.Empty;

  RequestState get onTheAirState => _onTheAirState;

  var _popularTV = <TV>[];

  List<TV> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.Empty;

  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <TV>[];

  List<TV> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.Empty;

  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';

  String get message => _message;

  TVListNotifier({
    required this.getTVOnTheAir,
    required this.getPopularTV,
    required this.getTopRatedTV,
  });

  final GetTVonTheAir getTVOnTheAir;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  Future<void> fetchTVOnTheAir() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTVOnTheAir.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirState = RequestState.Loaded;
        _tvOnTheAir = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        _popularTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTVState = RequestState.Loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        _topRatedTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTVState = RequestState.Loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
