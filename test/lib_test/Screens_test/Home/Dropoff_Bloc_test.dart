import 'package:bloc_test/bloc_test.dart';
import 'package:deliveryapp/Bloc/DropLocation/droplocation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  late DroplocationBloc dropLocationBloc;

  setUp(() {
    dropLocationBloc = DroplocationBloc();
  });
  tearDown(() {
    dropLocationBloc.close();
  });

  group('Drop-off location Bloc', () {

    LatLng location = const LatLng(53.2226,-4.1656) ;

    blocTest ("Change location state",
      build: ()=>dropLocationBloc,
      act: (bloc) => dropLocationBloc.add( OnChangeLocationEvent(location)),
      wait: const Duration(milliseconds: 1000),
      expect:()=> [dropLocationBloc.state.copyWith( existsLocation: true, location: location )],
    );
    blocTest ("Update if the map camera is ready state",
      build: ()=>dropLocationBloc,
      act: (bloc) => dropLocationBloc.add( OnMapReadyEvent()),
      wait: const Duration(milliseconds: 1000),
      expect:()=> [dropLocationBloc.state.copyWith( mapReady: true ) ],
    );

    blocTest ("Update camera position move is map state",
      build: ()=>dropLocationBloc,
      act: (bloc) => dropLocationBloc.add( OnMoveMapEvent(location)),
      wait: const Duration(milliseconds: 1000),
      expect:()=> [dropLocationBloc.state.copyWith( locationCentral: location ) ],
    );

  }
  );
}