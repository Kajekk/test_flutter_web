import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class CommunityTopicState extends Equatable {
  const CommunityTopicState();

  @override
  List<Object?> get props => [];
}

class CommunityTopicLoading extends CommunityTopicState {}

class CommunityTopicLoaded extends CommunityTopicState {
  final List<CommunityTopic>? listData;

  CommunityTopicLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class CommunityTopicFailure extends CommunityTopicState {
  final String message;

  CommunityTopicFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteCommunityTopicsProcessing extends CommunityTopicState {}

class DeleteCommunityTopicsSuccess extends CommunityTopicState {}

class DeleteCommunityTopicsFailure extends CommunityTopicState {
  final String message;

  DeleteCommunityTopicsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddCommunityTopicState extends Equatable {
  const AddCommunityTopicState();

  @override
  List<Object?> get props => [];
}

class AddCommunityTopicLoading extends AddCommunityTopicState {}

class AddCommunityTopicSuccess extends AddCommunityTopicState {
  // final List<EmotionalLog>? listData;

  AddCommunityTopicSuccess();

  @override
  List<Object?> get props => [];
}

class AddCommunityTopicFailure extends AddCommunityTopicState {
  final String message;

  AddCommunityTopicFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditCommunityTopicState extends Equatable {
  const EditCommunityTopicState();

  @override
  List<Object?> get props => [];
}

class EditCommunityTopicLoading extends EditCommunityTopicState {
  const EditCommunityTopicLoading();
}

class EditCommunityTopicSuccess extends EditCommunityTopicState {
  const EditCommunityTopicSuccess();
}

class EditCommunityTopicFailure extends EditCommunityTopicState {
  final String message;

  const EditCommunityTopicFailure({required this.message});

  @override
  List<Object> get props => [message];
}