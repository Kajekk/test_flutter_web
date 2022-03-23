import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class InclusiveEmploymentState extends Equatable {
  const InclusiveEmploymentState();

  @override
  List<Object?> get props => [];
}

class InclusiveEmploymentLoading extends InclusiveEmploymentState {}

class InclusiveEmploymentSuccess extends InclusiveEmploymentState {
  final List<InclusiveEmploymentForm>? listData;

  InclusiveEmploymentSuccess({this.listData});

  @override
  List<Object?> get props => [listData];
}

class InclusiveEmploymentFailure extends InclusiveEmploymentState {
  final String message;
  final String? status;

  InclusiveEmploymentFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class DeleteInclusiveEmploymentsProcessing extends InclusiveEmploymentState {}

class DeleteInclusiveEmploymentsSuccess extends InclusiveEmploymentState {}

class DeleteInclusiveEmploymentsFailure extends InclusiveEmploymentState {
  final String message;
  final String? status;

  DeleteInclusiveEmploymentsFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}



class AddInclusiveEmploymentState extends Equatable {
  const AddInclusiveEmploymentState();

  @override
  List<Object?> get props => [];
}

class AddInclusiveEmploymentLoading extends AddInclusiveEmploymentState {}

class AddInclusiveEmploymentSuccess extends AddInclusiveEmploymentState {
  const AddInclusiveEmploymentSuccess();

  @override
  List<Object?> get props => [];
}

class AddInclusiveEmploymentFailure extends AddInclusiveEmploymentState {
  final String message;

  AddInclusiveEmploymentFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditInclusiveEmploymentState extends Equatable {
  const EditInclusiveEmploymentState();

  @override
  List<Object?> get props => [];
}

class EditInclusiveEmploymentLoading extends EditInclusiveEmploymentState {}

class EditInclusiveEmploymentSuccess extends EditInclusiveEmploymentState {
  const EditInclusiveEmploymentSuccess();

  @override
  List<Object?> get props => [];
}

class EditInclusiveEmploymentFailure extends EditInclusiveEmploymentState {
  final String message;

  EditInclusiveEmploymentFailure({required this.message});

  @override
  List<Object> get props => [message];
}