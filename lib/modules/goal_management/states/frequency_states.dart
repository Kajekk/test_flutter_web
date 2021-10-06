import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class GoalFrequencyState extends Equatable {
  const GoalFrequencyState();

  @override
  List<Object?> get props => [];
}

class GoalFrequencyLoading extends GoalFrequencyState {}

class GoalFrequencyLoaded extends GoalFrequencyState {
  final List<GoalFrequency>? listData;

  GoalFrequencyLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class GoalFrequencyFailure extends GoalFrequencyState {
  final String message;
  final String? status;

  GoalFrequencyFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class DeleteGoalFrequenciesProcessing extends GoalFrequencyState {}

class DeleteGoalFrequenciesSuccess extends GoalFrequencyState {}

class DeleteGoalFrequenciesFailure extends GoalFrequencyState {
  final String message;
  final String? status;

  DeleteGoalFrequenciesFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class AddGoalFrequencyState extends Equatable {
  const AddGoalFrequencyState();

  @override
  List<Object?> get props => [];
}

class AddGoalFrequencyLoading extends AddGoalFrequencyState {}

class AddGoalFrequencySuccess extends AddGoalFrequencyState {
  const AddGoalFrequencySuccess();

  @override
  List<Object?> get props => [];
}

class AddGoalFrequencyFailure extends AddGoalFrequencyState {
  final String message;

  AddGoalFrequencyFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditGoalFrequencyState extends Equatable {
  const EditGoalFrequencyState();

  @override
  List<Object?> get props => [];
}

class EditGoalFrequencyLoading extends EditGoalFrequencyState {}

class EditGoalFrequencySuccess extends EditGoalFrequencyState {
  const EditGoalFrequencySuccess();

  @override
  List<Object?> get props => [];
}

class EditGoalFrequencyFailure extends EditGoalFrequencyState {
  final String message;

  EditGoalFrequencyFailure({required this.message});

  @override
  List<Object> get props => [message];
}