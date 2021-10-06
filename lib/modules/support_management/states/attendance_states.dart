import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceModel>? listData;

  AttendanceLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class AttendanceFailure extends AttendanceState {
  final String message;

  AttendanceFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteAttendancesProcessing extends AttendanceState {}

class DeleteAttendancesSuccess extends AttendanceState {}

class DeleteAttendancesFailure extends AttendanceState {
  final String message;
  final String? status;

  DeleteAttendancesFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class AddAttendanceState extends Equatable {
  const AddAttendanceState();

  @override
  List<Object?> get props => [];
}

class AddAttendanceLoading extends AddAttendanceState {}

class AddAttendanceSuccess extends AddAttendanceState {
  const AddAttendanceSuccess();

  @override
  List<Object?> get props => [];
}

class AddAttendanceFailure extends AddAttendanceState {
  final String message;

  AddAttendanceFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditAttendanceState extends Equatable {
  const EditAttendanceState();

  @override
  List<Object?> get props => [];
}

class EditAttendanceLoading extends EditAttendanceState {}

class EditAttendanceSuccess extends EditAttendanceState {
  const EditAttendanceSuccess();

  @override
  List<Object?> get props => [];
}

class EditAttendanceFailure extends EditAttendanceState {
  final String message;

  EditAttendanceFailure({required this.message});

  @override
  List<Object> get props => [message];
}