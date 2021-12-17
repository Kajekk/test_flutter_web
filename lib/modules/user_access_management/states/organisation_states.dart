import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class OrganisationState extends Equatable {
  const OrganisationState();

  @override
  List<Object?> get props => [];
}

class OrganisationLoading extends OrganisationState {}

class OrganisationLoaded extends OrganisationState {
  final List<Organisation>? listData;

  OrganisationLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class OrganisationFailure extends OrganisationState {
  final String message;

  OrganisationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddOrganisationState extends Equatable {
  const AddOrganisationState();

  @override
  List<Object?> get props => [];
}

class AddOrganisationLoading extends AddOrganisationState {}

class AddOrganisationSuccess extends AddOrganisationState {
  const AddOrganisationSuccess();

  @override
  List<Object?> get props => [];
}

class AddOrganisationFailure extends AddOrganisationState {
  final String message;

  AddOrganisationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditOrganisationState extends Equatable {
  const EditOrganisationState();

  @override
  List<Object?> get props => [];
}

class EditOrganisationLoading extends EditOrganisationState {}

class EditOrganisationSuccess extends EditOrganisationState {
  const EditOrganisationSuccess();

  @override
  List<Object?> get props => [];
}

class EditOrganisationFailure extends EditOrganisationState {
  final String message;

  EditOrganisationFailure({required this.message});

  @override
  List<Object> get props => [message];
}