import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTVRecommendations])
void main() {
  late TvRecommendationBloc mvRecommendationBloc;
  late MockGetTVRecommendations mockSearchTVs;

  setUp(() {
    mockSearchTVs = MockGetTVRecommendations();
    mvRecommendationBloc = TvRecommendationBloc(mockSearchTVs);
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
  final tId = 557;

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVs.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      return mvRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetRecommendation(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tId));
    },
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVs.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return mvRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetRecommendation(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tId));
    },
  );
}