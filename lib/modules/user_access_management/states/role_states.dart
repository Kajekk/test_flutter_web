import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object?> get props => [];
}

class RoleLoading extends RoleState {}

class RoleLoaded extends RoleState {
  final List<Role>? listData;

  RoleLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class RoleFailure extends RoleState {
  final String message;

  RoleFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddRoleState extends Equatable {
  const AddRoleState();

  @override
  List<Object?> get props => [];
}

class AddRoleLoading extends AddRoleState {}

class AddRoleSuccess extends AddRoleState {
  const AddRoleSuccess();

  @override
  List<Object?> get props => [];
}

class AddRoleFailure extends AddRoleState {
  final String message;

  AddRoleFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditRoleState extends Equatable {
  const EditRoleState();

  @override
  List<Object?> get props => [];
}

class EditRoleLoading extends EditRoleState {}

class EditRoleSuccess extends EditRoleState {
  const EditRoleSuccess();

  @override
  List<Object?> get props => [];
}

class EditRoleFailure extends EditRoleState {
  final String message;

  EditRoleFailure({required this.message});

  @override
  List<Object> get props => [message];
}