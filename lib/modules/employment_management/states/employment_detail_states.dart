import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

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

class DeleteEmploymentDetailsProcessing extends EmploymentDetailState {}

class DeleteEmploymentDetailsSuccess extends EmploymentDetailState {}

class DeleteEmploymentDetailsFailure extends EmploymentDetailState {
  final String message;
  final String? status;

  DeleteEmploymentDetailsFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class AddEmploymentState extends Equatable {
  const AddEmploymentState();

  @override
  List<Object?> get props => [];
}

class AddEmploymentLoading extends AddEmploymentState {}

class AddEmploymentSuccess extends AddEmploymentState {
  const AddEmploymentSuccess();

  @override
  List<Object?> get props => [];
}

class AddEmploymentFailure extends AddEmploymentState {
  final String message;

  AddEmploymentFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditEmploymentState extends Equatable {
  const EditEmploymentState();

  @override
  List<Object?> get props => [];
}

class EditEmploymentLoading extends EditEmploymentState {}

class EditEmploymentSuccess extends EditEmploymentState {
  const EditEmploymentSuccess();

  @override
  List<Object?> get props => [];
}

class EditEmploymentFailure extends EditEmploymentState {
  final String message;

  EditEmploymentFailure({required this.message});

  @override
  List<Object> get props => [message];
}