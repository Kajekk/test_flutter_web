import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class PwdAccountState extends Equatable {
  const PwdAccountState();

  @override
  List<Object?> get props => [];
}

class PwdAccountLoading extends PwdAccountState {}

class PwdAccountLoaded extends PwdAccountState {
  final List<Account>? listData;

  PwdAccountLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class PwdAccountFailure extends PwdAccountState {
  final String message;

  PwdAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPwdAccountState extends Equatable {
  const AddPwdAccountState();

  @override
  List<Object?> get props => [];
}

class AddPwdAccountLoading extends AddPwdAccountState {}

class AddPwdAccountSuccess extends AddPwdAccountState {
  const AddPwdAccountSuccess();

  @override
  List<Object?> get props => [];
}

class AddPwdAccountFailure extends AddPwdAccountState {
  final String message;

  AddPwdAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditPwdAccountState extends Equatable {
  const EditPwdAccountState();

  @override
  List<Object?> get props => [];
}

class EditPwdAccountLoading extends EditPwdAccountState {}

class EditPwdAccountSuccess extends EditPwdAccountState {
  const EditPwdAccountSuccess();

  @override
  List<Object?> get props => [];
}

class EditPwdAccountFailure extends EditPwdAccountState {
  final String message;

  EditPwdAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}