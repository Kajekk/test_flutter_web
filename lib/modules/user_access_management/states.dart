import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class EmotionalLogState extends Equatable {
  const EmotionalLogState();

  @override
  List<Object?> get props => [];
}

class EmotionalLoading extends EmotionalLogState {}

class EmotionalLoaded extends EmotionalLogState {
  final List<EmotionalLog>? listData;

  EmotionalLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class EmotionalFailure extends EmotionalLogState {
  final String message;

  EmotionalFailure({required this.message});

  @override
  List<Object> get props => [message];
}