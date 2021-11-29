import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class SupportLogState extends Equatable {
  const SupportLogState();

  @override
  List<Object?> get props => [];
}

class SupportLogLoading extends SupportLogState {}

class SupportLogLoaded extends SupportLogState {
  final List<SupportLog>? listData;

  SupportLogLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class SupportLogFailure extends SupportLogState {
  final String message;

  SupportLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}