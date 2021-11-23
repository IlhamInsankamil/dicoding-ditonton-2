part of 'mv_detail_bloc.dart';

abstract class MvDetailState extends Equatable {
  const MvDetailState();

  @override
  List<Object> get props => [];
}

class MvDetailEmpty extends MvDetailState {}

class MvDetailLoading extends MvDetailState {}

class MvDetailError extends MvDetailState {
  final String message;

  MvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MvDetailHasData extends MvDetailState {
  final MovieDetail result;

  MvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
