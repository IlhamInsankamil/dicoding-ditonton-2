import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int? isMovie;

  TVTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.isMovie,
  });

  factory TVTable.fromEntity(TVDetail movie) => TVTable(
        id: movie.id,
        title: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
        isMovie: 0,
      );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
        id: map['id'],
        title: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        isMovie: map['isMovie'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'isMovie': 0,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview, isMovie];
}
