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