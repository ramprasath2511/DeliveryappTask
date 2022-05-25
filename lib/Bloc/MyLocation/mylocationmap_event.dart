part of 'mylocationmap_bloc.dart';

@immutable
abstract class MylocationmapEvent extends Equatable{}

class OnChangeLocationEvent extends MylocationmapEvent {
  final LatLng location;

  OnChangeLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}


class OnMapReadyEvent extends MylocationmapEvent {
  @override
  List<Object?> get props => [];
}


class OnMoveMapEvent extends MylocationmapEvent {
  final LatLng location;

  OnMoveMapEvent(this.location);

  @override
  List<Object?> get props => [location];
}


class OnGetAddressLocationEvent extends MylocationmapEvent {
  final LatLng location;

  OnGetAddressLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}


