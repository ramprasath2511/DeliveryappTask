part of 'mylocationmap_bloc.dart';

@immutable
class MylocationmapState extends Equatable {

  final bool locationExists;
  final LatLng? location;
  final bool mapReady;
  final LatLng? locationCentral;
  final String addressName;

  const MylocationmapState({
    this.locationExists = false,
    this.location,
    this.mapReady = false,
    this.locationCentral,
    this.addressName = ''
  });

  MylocationmapState copyWith({ bool? existsLocation, LatLng? location, bool? mapReady, LatLng? locationCentral, String? addressName })
    => MylocationmapState(
      locationExists: existsLocation ?? locationExists,
      location: location ?? this.location,
      mapReady: mapReady ?? this.mapReady,
      locationCentral: locationCentral ?? this.locationCentral,
      addressName: addressName ?? this.addressName
    );

  @override
  List<Object?> get props => [locationExists,location, mapReady, locationCentral,addressName  ];

}


class LoadingMyLocationState extends MylocationmapState {}

class SuccessMyLocationState extends MylocationmapState {}

class FailureMyLocationState extends MylocationmapState {
  final String error;
  FailureMyLocationState(this.error);
}
