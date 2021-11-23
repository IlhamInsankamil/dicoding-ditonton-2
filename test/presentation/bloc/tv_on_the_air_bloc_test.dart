import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:ditonton/presentation/bloc/tv_on_the_air_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_on_the_air_bloc_test.mocks.dart';

@GenerateMocks([GetTVonTheAir])
void main() {
  late TvOnTheAirBloc tvOnTheAirBloc;
  late MockGetTVonTheAir mockGetOnTheAirTVs;

  setUp(() {
    mockGetOnTheAirTVs = MockGetTVonTheAir();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetOnTheAirTVs);
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

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(LoadOnTheAir()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTVs.execute());
    },
  );

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(LoadOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTVs.execute());
    },
  );
}