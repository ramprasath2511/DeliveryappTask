part of 'droplocation_bloc.dart';

@immutable
abstract class DroplocationEvent extends Equatable{}

class OnChangeLocationEvent extends DroplocationEvent {
  final LatLng location;

  OnChangeLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}


class OnMapReadyEvent extends DroplocationEvent {
  @override
  List<Object?> get props => [];
}


class OnMoveMapEvent extends DroplocationEvent {
  final LatLng location;

  OnMoveMapEvent(this.location);

  @override
  List<Object?> get props => [location];
}


class OnGetAddressLocationEvent extends DroplocationEvent {
  final LatLng location;

  OnGetAddressLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}


