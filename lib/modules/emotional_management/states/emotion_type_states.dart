import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class EmotionTypeState extends Equatable {
  const EmotionTypeState();

  @override
  List<Object?> get props => [];
}

class EmotionTypeLoading extends EmotionTypeState {}

class EmotionTypeLoaded extends EmotionTypeState {
  final List<EmotionType>? listData;

  EmotionTypeLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class EmotionTypeFailure extends EmotionTypeState {
  final String message;

  EmotionTypeFailure({required this.message});

  @override
  List<Object> get props => [message];
}