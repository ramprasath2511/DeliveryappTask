import 'package:bloc_test/bloc_test.dart';
import 'package:deliveryapp/Bloc/MyLocation/mylocationmap_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  late MylocationmapBloc mylocationmapBloc;

  setUp(() {
    mylocationmapBloc = MylocationmapBloc();
  });
  tearDown(() {
    mylocationmapBloc.close();
  });

  group('Pickup-location Bloc', () {

    LatLng location = const LatLng(53.2226,-4.1656) ;

    blocTest ("Change location state",
      build: ()=>mylocationmapBloc,
      act: (bloc) => mylocationmapBloc.add( OnChangeLocationEvent(location)),
      wait: const Duration(milliseconds: 1000),
      expect:()=> [mylocationmapBloc.state.copyWith( existsLocation: true, location: location )],
    );
    blocTest ("Update if the map camera is ready state",
      build: ()=>mylocationmapBloc,
      act: (bloc) => mylocationmapBloc.add( OnMapReadyEvent()),
      wait: const Duration(milliseconds: 1000),
      expect:()=> [mylocationmapBloc.state.copyWith( mapReady: true ) ],
    );

    blocTest ("Update camera position move is map state",
        build: ()=>mylocationmapBloc,
    act: (bloc) => mylocationmapBloc.add( OnMoveMapEvent(location)),
    wait: const Duration(milliseconds: 1000),
    expect:()=> [mylocationmapBloc.state.copyWith( locationCentral: location ) ],
    );

  }
  );
}