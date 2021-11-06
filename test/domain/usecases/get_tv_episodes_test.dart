import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_episodes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVepisodes usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVepisodes(mockTVRepository);
  });

  final tTvId = 2;
  final tSeasonNumber = 3;

  test('should get list of tv episodes from the repository', () async {
    // arrange
    when(mockTVRepository.getEpisodes(tTvId, tSeasonNumber))
        .thenAnswer((_) async => Right(testEpisodeList));
    // act
    final result = await usecase.execute(tTvId, tSeasonNumber, 'name');
    // assert
    expect(result, Right(testEpisodeList));
  });
}
