import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class EmploymentDetailState extends Equatable {
  const EmploymentDetailState();

  @override
  List<Object?> get props => [];
}

class EmploymentDetailLoading extends EmploymentDetailState {}

class EmploymentDetailLoaded extends EmploymentDetailState {
  final List<Employment>? listData;

  EmploymentDetailLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class EmploymentDetailFailure extends EmploymentDetailState {
  final String message;

  EmploymentDetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}