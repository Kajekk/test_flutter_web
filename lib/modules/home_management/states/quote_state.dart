import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

class QuoteLoading extends QuoteState {}

class QuoteSuccess extends QuoteState {
  final List<Quote>? listData;

  QuoteSuccess({this.listData});

  @override
  List<Object?> get props => [listData];
}

class QuoteFailure extends QuoteState {
  final String message;
  final String? status;

  QuoteFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}

class DeleteQuotesProcessing extends QuoteState {}

class DeleteQuotesSuccess extends QuoteState {}

class DeleteQuotesFailure extends QuoteState {
  final String message;
  final String? status;

  DeleteQuotesFailure({required this.message, this.status});

  @override
  List<Object> get props => [message];
}



class AddQuoteState extends Equatable {
  const AddQuoteState();

  @override
  List<Object?> get props => [];
}

class AddQuoteLoading extends AddQuoteState {}

class AddQuoteSuccess extends AddQuoteState {
  const AddQuoteSuccess();

  @override
  List<Object?> get props => [];
}

class AddQuoteFailure extends AddQuoteState {
  final String message;

  AddQuoteFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditQuoteState extends Equatable {
  const EditQuoteState();

  @override
  List<Object?> get props => [];
}

class EditQuoteLoading extends EditQuoteState {}

class EditQuoteSuccess extends EditQuoteState {
  const EditQuoteSuccess();

  @override
  List<Object?> get props => [];
}

class EditQuoteFailure extends EditQuoteState {
  final String message;

  EditQuoteFailure({required this.message});

  @override
  List<Object> get props => [message];
}