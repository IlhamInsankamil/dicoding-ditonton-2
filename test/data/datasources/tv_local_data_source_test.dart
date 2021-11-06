import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlistTV(testTVTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.insertWatchlistTV(testTVTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlistTV(testTVTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertWatchlistTV(testTVTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlistTV(testTVTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeWatchlistTV(testTVTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlistTV(testTVTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeWatchlistTV(testTVTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });
}
