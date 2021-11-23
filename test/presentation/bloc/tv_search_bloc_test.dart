import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchBloc tvSearchBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    tvSearchBloc = TVSearchBloc(mockSearchTV);
  });

  test('initial state should be empty', () {
    expect(tvSearchBloc.state, SearchEmpty());
  });

  final tTVModel = TV(
    backdropPath: '/path.jpg',
    firstAirDate: '2021-09-17',
    genreIds: [10759, 9648],
    id: 93405,
    name: 'Squid Game',
    originCountry: ['KR'],
    originalLanguage: 'ko',
    originalName: 'Squid Game',
    overview: 'overview',
    popularity: 5104.946,
    posterPath: '/path.jpg',
    voteAverage: 7.8,
    voteCount: 7893,
  );
  final tTVList = <TV>[tTVModel];
  final tQuery = 'squid';

  blocTest<TVSearchBloc, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );

  blocTest<TVSearchBloc, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
}