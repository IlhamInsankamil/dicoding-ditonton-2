import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late TvTopRatedBloc tvTopRatedBloc;
  late MockGetTopRatedTV mockGetTopRatedTVs;

  setUp(() {
    mockGetTopRatedTVs = MockGetTopRatedTV();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTopRatedTVs);
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

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(LoadTopRated()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(LoadTopRated()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );
}