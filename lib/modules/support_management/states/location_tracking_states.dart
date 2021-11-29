import 'package:equatable/equatable.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

class LocationTrackingState extends Equatable {
  const LocationTrackingState();

  @override
  List<Object?> get props => [];
}

class LocationTrackingLoading extends LocationTrackingState {}

class LocationTrackingLoaded extends LocationTrackingState {
  final List<LocationTracking>? listData;

  LocationTrackingLoaded({this.listData});

  @override
  List<Object?> get props => [listData];
}

class LocationTrackingFailure extends LocationTrackingState {
  final String message;

  LocationTrackingFailure({required this.message});

  @override
  List<Object> get props => [message];
}