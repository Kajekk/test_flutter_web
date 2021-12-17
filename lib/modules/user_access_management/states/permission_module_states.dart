import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class PermissionModuleState extends Equatable {
  const PermissionModuleState();

  @override
  List<Object?> get props => [];
}

class PermissionModuleLoading extends PermissionModuleState {}

class PermissionModuleLoaded extends PermissionModuleState {
  final List<PermissionModule>? listData;

  PermissionModuleLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class PermissionModuleFailure extends PermissionModuleState {
  final String message;

  PermissionModuleFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPermissionModuleState extends Equatable {
  const AddPermissionModuleState();

  @override
  List<Object?> get props => [];
}

class AddPermissionModuleLoading extends AddPermissionModuleState {}

class AddPermissionModuleSuccess extends AddPermissionModuleState {
  const AddPermissionModuleSuccess();

  @override
  List<Object?> get props => [];
}

class AddPermissionModuleFailure extends AddPermissionModuleState {
  final String message;

  AddPermissionModuleFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditPermissionModuleState extends Equatable {
  const EditPermissionModuleState();

  @override
  List<Object?> get props => [];
}

class EditPermissionModuleLoading extends EditPermissionModuleState {}

class EditPermissionModuleSuccess extends EditPermissionModuleState {
  const EditPermissionModuleSuccess();

  @override
  List<Object?> get props => [];
}

class EditPermissionModuleFailure extends EditPermissionModuleState {
  final String message;

  EditPermissionModuleFailure({required this.message});

  @override
  List<Object> get props => [message];
}