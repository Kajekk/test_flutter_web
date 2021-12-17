import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object?> get props => [];
}

class PermissionLoading extends PermissionState {}

class PermissionLoaded extends PermissionState {
  final List<Permission>? listData;

  PermissionLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class PermissionFailure extends PermissionState {
  final String message;

  PermissionFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPermissionState extends Equatable {
  const AddPermissionState();

  @override
  List<Object?> get props => [];
}

class AddPermissionLoading extends AddPermissionState {}

class AddPermissionSuccess extends AddPermissionState {
  const AddPermissionSuccess();

  @override
  List<Object?> get props => [];
}

class AddPermissionFailure extends AddPermissionState {
  final String message;

  AddPermissionFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditPermissionState extends Equatable {
  const EditPermissionState();

  @override
  List<Object?> get props => [];
}

class EditPermissionLoading extends EditPermissionState {}

class EditPermissionSuccess extends EditPermissionState {
  const EditPermissionSuccess();

  @override
  List<Object?> get props => [];
}

class EditPermissionFailure extends EditPermissionState {
  final String message;

  EditPermissionFailure({required this.message});

  @override
  List<Object> get props => [message];
}