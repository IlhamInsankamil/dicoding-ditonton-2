import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late TvPopularBloc tvPopularBloc;
  late MockGetPopularTV mockGetPopularTVs;

  setUp(() {
    mockGetPopularTVs = MockGetPopularTV();
    tvPopularBloc = TvPopularBloc(mockGetPopularTVs);
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

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(LoadPopular()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(LoadPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );
}