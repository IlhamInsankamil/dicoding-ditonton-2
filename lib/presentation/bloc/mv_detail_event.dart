part of 'mv_detail_bloc.dart';

abstract class MvDetailEvent extends Equatable {
  const MvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetail extends MvDetailEvent {
  final int id;

  GetDetail(this.id);

  @override
  List<Object> get props => [id];
}
