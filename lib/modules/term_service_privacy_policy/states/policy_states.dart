import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/barrel.dart';

class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object?> get props => [];
}

class PolicyLoading extends PolicyState {}

class PolicyLoaded extends PolicyState {
  final List<Policy>? listData;

  PolicyLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class PolicyFailure extends PolicyState {
  final String message;

  PolicyFailure({required this.message});

  @override
  List<Object> get props => [message];
}