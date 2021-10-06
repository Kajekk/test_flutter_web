import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

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

class DeleteEmotionalLogsProcessing extends EmotionalLogState {}

class DeleteEmotionalLogsSuccess extends EmotionalLogState {}

class DeleteEmotionalLogsFailure extends EmotionalLogState {
  final String message;

  DeleteEmotionalLogsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddEmotionalLogState extends Equatable {
  const AddEmotionalLogState();

  @override
  List<Object?> get props => [];
}

class AddEmotionalLogLoading extends AddEmotionalLogState {}

class AddEmotionalLogSuccess extends AddEmotionalLogState {
  // final List<EmotionalLog>? listData;

  AddEmotionalLogSuccess();

  @override
  List<Object?> get props => [];
}

class AddEmotionalLogFailure extends AddEmotionalLogState {
  final String message;

  AddEmotionalLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditEmotionalLogState extends Equatable {
  const EditEmotionalLogState();

  @override
  List<Object?> get props => [];
}

class EditEmotionalLogLoading extends EditEmotionalLogState {
  const EditEmotionalLogLoading();
}

class EditEmotionalLogSuccess extends EditEmotionalLogState {
  const EditEmotionalLogSuccess();
}

class EditEmotionalLogFailure extends EditEmotionalLogState {
  final String message;

  const EditEmotionalLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}