part of 'droplocation_bloc.dart';

@immutable
class DroplocationState extends Equatable{

  final bool locationExists;
  final LatLng? location;
  final bool mapReady;
  final LatLng? locationCentral;
  final String addressName;

  const DroplocationState({
    this.locationExists = false,
    this.location,
    this.mapReady = false,
    this.locationCentral,
    this.addressName = ''
  });

  DroplocationState copyWith({ bool? existsLocation, LatLng? location, bool? mapReady, LatLng? locationCentral, String? addressName })
  => DroplocationState(
      locationExists: existsLocation ?? this.locationExists,
      location: location ?? this.location,
      mapReady: mapReady ?? this.mapReady,
      locationCentral: locationCentral ?? this.locationCentral,
      addressName: addressName ?? this.addressName
  );

  @override
  List<Object?> get props => [locationExists,location, mapReady, locationCentral,addressName  ];

}


class LoadingMyLocationState extends DroplocationState {}

class SuccessMyLocationState extends DroplocationState {}

class FailureMyLocationState extends DroplocationState {
  final String error;
  FailureMyLocationState(this.error);
}
