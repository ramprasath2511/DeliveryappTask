import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Widgets/ThemeMaps.dart';


part 'droplocation_event.dart';
part 'droplocation_state.dart';

class DroplocationBloc extends Bloc<DroplocationEvent, DroplocationState> {

  DroplocationBloc() : super(DroplocationState()){

    on<OnChangeLocationEvent>( _onChangeLocation );
    on<OnMapReadyEvent>( _onMapReady );
    on<OnMoveMapEvent>( _onMoveMap );
    on<OnGetAddressLocationEvent>( _onGetAddressLocation );

  }


  late GoogleMapController _mapController;
  late StreamSubscription<Position> _positionSubscription;


  void initialLocation() async {

    _positionSubscription = Geolocator.getPositionStream().listen((Position position) {

      add( OnChangeLocationEvent(LatLng(position.latitude, position.longitude)) );

    });

  }
  void cancelLocation(){
    _positionSubscription.cancel();
  }
  void initMapLocation( GoogleMapController controller ){

    if( !state.mapReady ){
      this._mapController = controller;
      // Change Style from Map
      _mapController.setMapStyle( jsonEncode( themeMapsDapp ));

      add( OnMapReadyEvent() );

      add( OnGetAddressLocationEvent( state.location! ) );
    }

  }




  Future<void> _onChangeLocation( OnChangeLocationEvent event, Emitter<DroplocationState> emit ) async {

    emit( state.copyWith( existsLocation: true, location: event.location ) );

  }

  Future<void> _onMapReady( OnMapReadyEvent event, Emitter<DroplocationState> emit ) async {

    emit( state.copyWith( mapReady: true ) );

  }

  Future<void> _onMoveMap( OnMoveMapEvent event, Emitter<DroplocationState> emit ) async {

    emit( state.copyWith( locationCentral: event.location ) );

  }

  Future<void> _onGetAddressLocation( OnGetAddressLocationEvent event, Emitter<DroplocationState> emit ) async {

    List<Placemark> address = await placemarkFromCoordinates( event.location.latitude , event.location.longitude );
    String direction = address[0].thoroughfare!;
    String street = address[0].subThoroughfare!;
    String city = address[0].locality!;

    emit( state.copyWith(
      addressName: '$direction, #$street, $city',
    ));
  }


}
