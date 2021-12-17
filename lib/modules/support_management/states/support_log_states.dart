import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class SupportLogState extends Equatable {
  const SupportLogState();

  @override
  List<Object?> get props => [];
}

class SupportLogLoading extends SupportLogState {}

class SupportLogLoaded extends SupportLogState {
  final List<SupportLog>? listData;

  SupportLogLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class SupportLogFailure extends SupportLogState {
  final String message;

  SupportLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddSupportLogState extends Equatable {
  const AddSupportLogState();

  @override
  List<Object?> get props => [];
}

class AddSupportLogLoading extends AddSupportLogState {}

class AddSupportLogSuccess extends AddSupportLogState {
  const AddSupportLogSuccess();

  @override
  List<Object?> get props => [];
}

class AddSupportLogFailure extends AddSupportLogState {
  final String message;

  AddSupportLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditSupportLogState extends Equatable {
  const EditSupportLogState();

  @override
  List<Object?> get props => [];
}

class EditSupportLogLoading extends EditSupportLogState {}

class EditSupportLogSuccess extends EditSupportLogState {
  const EditSupportLogSuccess();

  @override
  List<Object?> get props => [];
}

class EditSupportLogFailure extends EditSupportLogState {
  final String message;

  EditSupportLogFailure({required this.message});

  @override
  List<Object> get props => [message];
}