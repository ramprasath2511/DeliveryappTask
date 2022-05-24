part of 'droplocation_bloc.dart';

@immutable
class DroplocationState {

  final bool existsLocation;
  final LatLng? location;
  final bool mapReady;
  final LatLng? locationCentral;
  final String addressName;

  DroplocationState({
    this.existsLocation = false,
    this.location,
    this.mapReady = false,
    this.locationCentral,
    this.addressName = ''
  });

  DroplocationState copyWith({ bool? existsLocation, LatLng? location, bool? mapReady, LatLng? locationCentral, String? addressName })
  => DroplocationState(
      existsLocation: existsLocation ?? this.existsLocation,
      location: location ?? this.location,
      mapReady: mapReady ?? this.mapReady,
      locationCentral: locationCentral ?? this.locationCentral,
      addressName: addressName ?? this.addressName
  );

}


class LoadingMyLocationState extends DroplocationState {}

class SuccessMyLocationState extends DroplocationState {}

class FailureMyLocationState extends DroplocationState {
  final String error;
  FailureMyLocationState(this.error);
}
