import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2006-09-18',
    genreIds: [1],
    id: 1,
    name: 'Rachael Ray',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Rachael Ray',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTVResponseModel =
  TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_on_the_air.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2006-09-18",
            "genre_ids": [1],
            "id": 1,
            "name": "Rachael Ray",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Rachael Ray",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
