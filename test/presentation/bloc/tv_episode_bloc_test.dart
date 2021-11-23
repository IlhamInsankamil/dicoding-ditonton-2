import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_episodes.dart';
import 'package:ditonton/presentation/bloc/tv_episode_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_episode_bloc_test.mocks.dart';

@GenerateMocks([GetTVepisodes])
void main() {
  late TvEpisodeBloc tvEpisodeBloc;
  late MockGetTVepisodes mockGetEpisodeTVs;

  setUp(() {
    mockGetEpisodeTVs = MockGetTVepisodes();
    tvEpisodeBloc = TvEpisodeBloc(mockGetEpisodeTVs);
  });

  final tTVEpisodeModel = Episode(
    airDate: '2021-09-17',
    episodeNumber: 1,
    id: 1922715,
    name: 'Red Light, Green Light',
    overview: 'overview',
    productionCode: '',
    seasonNumber: 1,
    stillPath: '/path.jpg',
    voteAverage: 8.0,
    voteCount: 44,
  );
  final tTVEpisodeList = <Episode>[tTVEpisodeModel];

  final tId = 2;
  final tSeasonNumber = 1;
  final tSeasonName = 'SeasonName';

  blocTest<TvEpisodeBloc, TvEpisodeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetEpisodeTVs.execute(tId, tSeasonNumber, tSeasonName))
          .thenAnswer((_) async => Right(tTVEpisodeList));
      return tvEpisodeBloc;
    },
    act: (bloc) => bloc.add(GetEpisode(tId, tSeasonNumber, tSeasonName)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvEpisodeLoading(),
      TvEpisodeHasData(tTVEpisodeList),
    ],
    verify: (bloc) {
      verify(mockGetEpisodeTVs.execute(tId, tSeasonNumber, tSeasonName));
    },
  );

  blocTest<TvEpisodeBloc, TvEpisodeState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetEpisodeTVs.execute(tId, tSeasonNumber, tSeasonName))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvEpisodeBloc;
    },
    act: (bloc) => bloc.add(GetEpisode(tId, tSeasonNumber, tSeasonName)),
    expect: () => [
      TvEpisodeLoading(),
      TvEpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetEpisodeTVs.execute(tId, tSeasonNumber, tSeasonName));
    },
  );
}