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