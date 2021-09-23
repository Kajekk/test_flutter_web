import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class GoalRelationshipState extends Equatable {
  const GoalRelationshipState();

  @override
  List<Object?> get props => [];
}

class GoalRelationshipLoading extends GoalRelationshipState {}

class GoalRelationshipLoaded extends GoalRelationshipState {
  final List<GoalRelationship>? listData;

  GoalRelationshipLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class GoalRelationshipFailure extends GoalRelationshipState {
  final String message;
  final String? status;

  GoalRelationshipFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class AddGoalRelationshipState extends Equatable {
  const AddGoalRelationshipState();

  @override
  List<Object?> get props => [];
}

class AddGoalRelationshipLoading extends AddGoalRelationshipState {}

class AddGoalRelationshipSuccess extends AddGoalRelationshipState {
  const AddGoalRelationshipSuccess();

  @override
  List<Object?> get props => [];
}

class AddGoalRelationshipFailure extends AddGoalRelationshipState {
  final String message;

  AddGoalRelationshipFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditGoalRelationshipState extends Equatable {
  const EditGoalRelationshipState();

  @override
  List<Object?> get props => [];
}

class EditGoalRelationshipLoading extends EditGoalRelationshipState {}

class EditGoalRelationshipSuccess extends EditGoalRelationshipState {
  const EditGoalRelationshipSuccess();

  @override
  List<Object?> get props => [];
}

class EditGoalRelationshipFailure extends EditGoalRelationshipState {
  final String message;

  EditGoalRelationshipFailure({required this.message});

  @override
  List<Object> get props => [message];
}