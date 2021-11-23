import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVDetail])
void main() {
  late TvDetailBloc mvDetailBloc;
  late MockGetTVDetail mockGetTVDetail;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mvDetailBloc = TvDetailBloc(mockGetTVDetail);
  });

  final tTVModel = TVDetail(
      backdropPath: '/path.jpg',
      createdBy: ['created_by'],
      episodeRunTime: [54],
      firstAirDate: new DateTime(2021, 09, 17),
      genres: <Genre>[Genre(id: 1, name: 'Action')],
      homepage: 'https://www.netflix.com/title/81040344',
      id: 2,
      inProduction: false,
      languages: ['en', 'el'],
      lastAirDate: new DateTime(2021, 09, 17),
      name: 'Squid Game',
      numberOfEpisodes: 9,
      numberOfSeasons: 1,
      originCountry: ['KR'],
      originalName: 'Squid Game',
      overview: 'overview',
      popularity: 5104.946,
      posterPath: '/path.jpg',
      status: 'Ended',
      tagline: "45.6 billion won is child's play.",
      type: 'Scripted',
      voteAverage: 7.8,
      voteCount: 7897,
      originalLanguage: 'ko',
      seasons: <Season>[
        Season(
            airDate: '2021-09-17',
            episodeCount: 9,
            id: 1,
            name: 'Season 1',
            overview: 'overview',
            posterPath: '/path.jpg',
            seasonNumber: 3,
            episodes: null)
      ]);

  final tId = 2;

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(tTVModel));
      return mvDetailBloc;
    },
    act: (bloc) => bloc.add(GetDetail(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(tTVModel),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return mvDetailBloc;
    },
    act: (bloc) => bloc.add(GetDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );
}
