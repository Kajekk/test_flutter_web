import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class ProAccountState extends Equatable {
  const ProAccountState();

  @override
  List<Object?> get props => [];
}

class ProAccountLoading extends ProAccountState {}

class ProAccountLoaded extends ProAccountState {
  final List<Account>? listData;

  ProAccountLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class ProAccountFailure extends ProAccountState {
  final String message;

  ProAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddProAccountState extends Equatable {
  const AddProAccountState();

  @override
  List<Object?> get props => [];
}

class AddProAccountLoading extends AddProAccountState {}

class AddProAccountSuccess extends AddProAccountState {
  const AddProAccountSuccess();

  @override
  List<Object?> get props => [];
}

class AddProAccountFailure extends AddProAccountState {
  final String message;

  AddProAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditProAccountState extends Equatable {
  const EditProAccountState();

  @override
  List<Object?> get props => [];
}

class EditProAccountLoading extends EditProAccountState {}

class EditProAccountSuccess extends EditProAccountState {
  const EditProAccountSuccess();

  @override
  List<Object?> get props => [];
}

class EditProAccountFailure extends EditProAccountState {
  final String message;

  EditProAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}