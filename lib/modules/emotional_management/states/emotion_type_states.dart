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

class AddEmotionTypeState extends Equatable {
  const AddEmotionTypeState();

  @override
  List<Object?> get props => [];
}

class AddEmotionTypeLoading extends AddEmotionTypeState {}

class AddEmotionTypeSuccess extends AddEmotionTypeState {
  // final List<EmotionalLog>? listData;

  AddEmotionTypeSuccess();

  @override
  List<Object?> get props => [];
}

class AddEmotionTypeFailure extends AddEmotionTypeState {
  final String message;

  AddEmotionTypeFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditEmotionTypeState extends Equatable {
  const EditEmotionTypeState();

  @override
  List<Object?> get props => [];
}

class EditEmotionTypeLoading extends EditEmotionTypeState {
  const EditEmotionTypeLoading();
}

class EditEmotionTypeSuccess extends EditEmotionTypeState {
  const EditEmotionTypeSuccess();
}

class EditEmotionTypeFailure extends EditEmotionTypeState {
  final String message;

  const EditEmotionTypeFailure({required this.message});

  @override
  List<Object> get props => [message];
}