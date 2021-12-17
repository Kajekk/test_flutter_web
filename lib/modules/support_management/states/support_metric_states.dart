import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class SupportMetricState extends Equatable {
  const SupportMetricState();

  @override
  List<Object?> get props => [];
}

class SupportMetricLoading extends SupportMetricState {}

class SupportMetricLoaded extends SupportMetricState {
  final List<SupportMetric>? listData;

  SupportMetricLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class SupportMetricFailure extends SupportMetricState {
  final String message;

  SupportMetricFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddSupportMetricState extends Equatable {
  const AddSupportMetricState();

  @override
  List<Object?> get props => [];
}

class AddSupportMetricLoading extends AddSupportMetricState {}

class AddSupportMetricSuccess extends AddSupportMetricState {
  const AddSupportMetricSuccess();

  @override
  List<Object?> get props => [];
}

class AddSupportMetricFailure extends AddSupportMetricState {
  final String message;

  AddSupportMetricFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EditSupportMetricState extends Equatable {
  const EditSupportMetricState();

  @override
  List<Object?> get props => [];
}

class EditSupportMetricLoading extends EditSupportMetricState {}

class EditSupportMetricSuccess extends EditSupportMetricState {
  const EditSupportMetricSuccess();

  @override
  List<Object?> get props => [];
}

class EditSupportMetricFailure extends EditSupportMetricState {
  final String message;

  EditSupportMetricFailure({required this.message});

  @override
  List<Object> get props => [message];
}