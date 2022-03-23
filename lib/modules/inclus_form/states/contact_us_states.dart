import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object?> get props => [];
}

class ContactUsLoading extends ContactUsState {}

class ContactUsSuccess extends ContactUsState {
  final List<ContactUsForm>? listData;

  ContactUsSuccess({this.listData});

  @override
  List<Object?> get props => [listData];
}

class ContactUsFailure extends ContactUsState {
  final String message;
  final String? status;

  ContactUsFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class DeleteContactUsProcessing extends ContactUsState {}

class DeleteContactUsSuccess extends ContactUsState {}

class DeleteContactUsFailure extends ContactUsState {
  final String message;
  final String? status;

  DeleteContactUsFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}



class AddContactUsState extends Equatable {
  const AddContactUsState();

  @override
  List<Object?> get props => [];
}

class AddContactUsLoading extends AddContactUsState {}

class AddContactUsSuccess extends AddContactUsState {
  const AddContactUsSuccess();

  @override
  List<Object?> get props => [];
}

class AddContactUsFailure extends AddContactUsState {
  final String message;

  AddContactUsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditContactUsState extends Equatable {
  const EditContactUsState();

  @override
  List<Object?> get props => [];
}

class EditContactUsLoading extends EditContactUsState {}

class EditContactUsSuccess extends EditContactUsState {
  const EditContactUsSuccess();

  @override
  List<Object?> get props => [];
}

class EditContactUsFailure extends EditContactUsState {
  final String message;

  EditContactUsFailure({required this.message});

  @override
  List<Object> get props => [message];
}