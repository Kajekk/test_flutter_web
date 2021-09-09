import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class EmotionalLogState extends Equatable {
  const EmotionalLogState();

  @override
  List<Object?> get props => [];
}

class EmotionalLogLoading extends EmotionalLogState {}

class EmotionalLogLoaded extends EmotionalLogState {
  final List<EmotionalLog>? listData;

  EmotionalLogLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class EmotionalLogFailure extends EmotionalLogState {
  final String message;

  EmotionalLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}