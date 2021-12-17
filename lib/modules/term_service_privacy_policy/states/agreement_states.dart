import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class AgreementState extends Equatable {
  const AgreementState();

  @override
  List<Object?> get props => [];
}

class AgreementLoading extends AgreementState {}

class AgreementLoaded extends AgreementState {
  final List<Agreement>? listData;

  AgreementLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class AgreementFailure extends AgreementState {
  final String message;

  AgreementFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddAgreementState extends Equatable {
  const AddAgreementState();

  @override
  List<Object?> get props => [];
}

class AddAgreementLoading extends AddAgreementState {}

class AddAgreementSuccess extends AddAgreementState {
  const AddAgreementSuccess();

  @override
  List<Object?> get props => [];
}

class AddAgreementFailure extends AddAgreementState {
  final String message;

  AddAgreementFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditAgreementState extends Equatable {
  const EditAgreementState();

  @override
  List<Object?> get props => [];
}

class EditAgreementLoading extends EditAgreementState {}

class EditAgreementSuccess extends EditAgreementState {
  const EditAgreementSuccess();

  @override
  List<Object?> get props => [];
}

class EditAgreementFailure extends EditAgreementState {
  final String message;

  EditAgreementFailure({required this.message});

  @override
  List<Object> get props => [message];
}