import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/workplace_detail.dart';

class WorkplaceDetailState extends Equatable {
  const WorkplaceDetailState();

  @override
  List<Object?> get props => [];
}

class WorkplaceDetailLoading extends WorkplaceDetailState {}

class WorkplaceDetailLoaded extends WorkplaceDetailState {
  final List<WorkplaceDetail>? listData;

  WorkplaceDetailLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class WorkplaceDetailFailure extends WorkplaceDetailState {
  final String message;

  WorkplaceDetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}


class AddWorkplaceDetailState extends Equatable {
  const AddWorkplaceDetailState();

  @override
  List<Object?> get props => [];
}

class AddWorkplaceDetailLoading extends AddWorkplaceDetailState {}

class AddWorkplaceDetailSuccess extends AddWorkplaceDetailState {
  const AddWorkplaceDetailSuccess();

  @override
  List<Object?> get props => [];
}

class AddWorkplaceDetailFailure extends AddWorkplaceDetailState {
  final String message;

  AddWorkplaceDetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}


class EditWorkplaceDetailState extends Equatable {
  const EditWorkplaceDetailState();

  @override
  List<Object?> get props => [];
}

class EditWorkplaceDetailLoading extends EditWorkplaceDetailState {}

class EditWorkplaceDetailSuccess extends EditWorkplaceDetailState {
  const EditWorkplaceDetailSuccess();

  @override
  List<Object?> get props => [];
}

class EditWorkplaceDetailFailure extends EditWorkplaceDetailState {
  final String message;

  EditWorkplaceDetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}