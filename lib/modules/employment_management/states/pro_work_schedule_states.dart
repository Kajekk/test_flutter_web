import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class ProWorkScheduleState extends Equatable {
  const ProWorkScheduleState();

  @override
  List<Object?> get props => [];
}

class ProWorkScheduleLoading extends ProWorkScheduleState {}

class ProWorkScheduleLoaded extends ProWorkScheduleState {
  final List<ProWorkSchedule>? listData;

  ProWorkScheduleLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class ProWorkScheduleFailure extends ProWorkScheduleState {
  final String message;

  ProWorkScheduleFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteProWorkSchedulesProcessing extends ProWorkScheduleState {}

class DeleteProWorkSchedulesSuccess extends ProWorkScheduleState {}

class DeleteProWorkSchedulesFailure extends ProWorkScheduleState {
  final String message;
  final String? status;

  DeleteProWorkSchedulesFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class AddProWorkScheduleState extends Equatable {
  const AddProWorkScheduleState();

  @override
  List<Object?> get props => [];
}

class AddProWorkScheduleLoading extends AddProWorkScheduleState {}

class AddProWorkScheduleSuccess extends AddProWorkScheduleState {
  const AddProWorkScheduleSuccess();

  @override
  List<Object?> get props => [];
}

class AddProWorkScheduleFailure extends AddProWorkScheduleState {
  final String message;

  AddProWorkScheduleFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditProWorkScheduleState extends Equatable {
  const EditProWorkScheduleState();

  @override
  List<Object?> get props => [];
}

class EditProWorkScheduleLoading extends EditProWorkScheduleState {}

class EditProWorkScheduleSuccess extends EditProWorkScheduleState {
  const EditProWorkScheduleSuccess();

  @override
  List<Object?> get props => [];
}

class EditProWorkScheduleFailure extends EditProWorkScheduleState {
  final String message;

  EditProWorkScheduleFailure({required this.message});

  @override
  List<Object> get props => [message];
}