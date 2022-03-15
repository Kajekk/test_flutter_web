import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final List<Account>? listData;

  AccountLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class AccountFailure extends AccountState {
  final String message;

  AccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddAccountState extends Equatable {
  const AddAccountState();

  @override
  List<Object?> get props => [];
}

class AddAccountLoading extends AddAccountState {}

class AddAccountSuccess extends AddAccountState {
  const AddAccountSuccess();

  @override
  List<Object?> get props => [];
}

class AddAccountFailure extends AddAccountState {
  final String message;

  AddAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditAccountState extends Equatable {
  const EditAccountState();

  @override
  List<Object?> get props => [];
}

class EditAccountLoading extends EditAccountState {}

class EditAccountSuccess extends EditAccountState {
  const EditAccountSuccess();

  @override
  List<Object?> get props => [];
}

class EditAccountFailure extends EditAccountState {
  final String message;

  EditAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}