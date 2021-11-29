import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class GoalTrackingState extends Equatable {
  const GoalTrackingState();

  @override
  List<Object?> get props => [];
}

class GoalTrackingLoading extends GoalTrackingState {}

class GoalTrackingLoaded extends GoalTrackingState {
  final List<GoalTracking>? listData;

  GoalTrackingLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class GoalTrackingFailure extends GoalTrackingState {
  final String message;
  final String? status;

  GoalTrackingFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class EditGoalTrackingState extends Equatable {
  const EditGoalTrackingState();

  @override
  List<Object?> get props => [];
}

class EditGoalTrackingLoading extends EditGoalTrackingState {}

class EditGoalTrackingSuccess extends EditGoalTrackingState {
  const EditGoalTrackingSuccess();

  @override
  List<Object?> get props => [];
}

class EditGoalTrackingFailure extends EditGoalTrackingState {
  final String message;

  EditGoalTrackingFailure({required this.message});

  @override
  List<Object> get props => [message];
}