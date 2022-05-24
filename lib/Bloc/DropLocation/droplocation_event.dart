part of 'droplocation_bloc.dart';

@immutable
abstract class DroplocationEvent {}

class OnChangeLocationEvent extends DroplocationEvent {
  final LatLng location;

  OnChangeLocationEvent(this.location);
}


class OnMapReadyEvent extends DroplocationEvent {}


class OnMoveMapEvent extends DroplocationEvent {
  final LatLng location;

  OnMoveMapEvent(this.location);
}


class OnGetAddressLocationEvent extends DroplocationEvent {
  final LatLng location;

  OnGetAddressLocationEvent(this.location);
}


