import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    isMovie: 1);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: 1,
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'isMovie': 1,
};

final testTV = TV(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [1],
  id: 2,
  name: 'name',
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 3,
  posterPath: 'posterPath',
  voteAverage: 4,
  voteCount: 5,
);

final testTVList = [testTV];

DateTime now = new DateTime.now();
DateTime tmrw = new DateTime.now().add(Duration(days: 1));

final testTVDetail = TVDetail(
  backdropPath: 'backdropPath',
  createdBy: ['createdBy'],
  episodeRunTime: [1],
  firstAirDate: DateTime(now.year, now.month, now.day),
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 2,
  inProduction: true,
  languages: ['languages'],
  lastAirDate: DateTime(tmrw.year, tmrw.month, tmrw.day),
  name: 'name',
  numberOfEpisodes: 3,
  numberOfSeasons: 4,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 5.0,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 6.0,
  voteCount: 7,
  seasons: testSeasonList,
);

final testSeasonList = [
  Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 2,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 3,
      episodes: testEpisodeList)
];

final testEpisodeList = [
  Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 2,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 3,
      stillPath: 'stillPath',
      voteAverage: 4.0,
      voteCount: 5)
];

final testTVTable = TVTable(
  id: 2,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: 0,
);

final testTVMap = {
  'id': 2,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'isMovie': 0,
};
