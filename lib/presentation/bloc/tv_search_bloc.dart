import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TVSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTV _searchTV;

  TVSearchBloc(this._searchTV) : super(SearchEmpty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;
      print(query);

      yield SearchLoading();
      final result = await _searchTV.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasData(data);
        },
      );
    }
  }
}
