// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/bloc/mv_watchlist_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/domain/entities/movie.dart' as _i8;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i11;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i14;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i3;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i4;
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart' as _i5;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i9;
import 'package:ditonton/domain/usecases/remove_watchlist.dart' as _i12;
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart' as _i15;
import 'package:ditonton/domain/usecases/save_watchlist.dart' as _i10;
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart' as _i13;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieRepository extends _i1.Fake implements _i3.MovieRepository {}

class _FakeTVRepository extends _i1.Fake implements _i4.TVRepository {}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i5.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i9.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i3.MovieRepository);
  @override
  _i6.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i10.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i3.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> execute(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i12.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i3.MovieRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> execute(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
}

/// A class which mocks [SaveWatchlistTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTV extends _i1.Mock implements _i13.SaveWatchlistTV {
  MockSaveWatchlistTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i4.TVRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> execute(_i14.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTV extends _i1.Mock implements _i15.RemoveWatchlistTV {
  MockRemoveWatchlistTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i4.TVRepository);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> execute(_i14.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
}