import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class GoalState extends Equatable {
  const GoalState();

  @override
  List<Object?> get props => [];
}

class GoalLoading extends GoalState {}

class GoalLoaded extends GoalState {
  final List<Goal>? listData;

  GoalLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class GoalFailure extends GoalState {
  final String message;
  final String? status;

  GoalFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class AddGoalState extends Equatable {
  const AddGoalState();

  @override
  List<Object?> get props => [];
}

class AddGoalLoading extends AddGoalState {}

class AddGoalSuccess extends AddGoalState {
  const AddGoalSuccess();

  @override
  List<Object?> get props => [];
}

class AddGoalFailure extends AddGoalState {
  final String message;

  AddGoalFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditGoalState extends Equatable {
  const EditGoalState();

  @override
  List<Object?> get props => [];
}

class EditGoalLoading extends EditGoalState {}

class EditGoalSuccess extends EditGoalState {
  const EditGoalSuccess();

  @override
  List<Object?> get props => [];
}

class EditGoalFailure extends EditGoalState {
  final String message;

  EditGoalFailure({required this.message});

  @override
  List<Object> get props => [message];
}