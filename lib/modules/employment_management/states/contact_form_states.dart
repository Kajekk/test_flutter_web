import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class ContactFormState extends Equatable {
  const ContactFormState();

  @override
  List<Object?> get props => [];
}

class ContactFormLoading extends ContactFormState {}

class ContactFormLoaded extends ContactFormState {
  final List<ContactForm>? listData;

  ContactFormLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class ContactFormFailure extends ContactFormState {
  final String message;

  ContactFormFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteContactFormProcessing extends ContactFormState {}

class DeleteContactFormSuccess extends ContactFormState {}

class DeleteContactFormFailure extends ContactFormState {
  final String message;
  final String? status;

  DeleteContactFormFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}