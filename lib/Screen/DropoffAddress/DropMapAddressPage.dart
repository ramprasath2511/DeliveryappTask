import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/DropLocation/droplocation_bloc.dart';
import 'DropManualMarket.dart';
import '../../Widgets/textDapp.dart';

class DropLocationAddressPage extends StatefulWidget {
  @override
  _DropLocationAddressPageState createState() => _DropLocationAddressPageState();
}
class _DropLocationAddressPageState extends State<DropLocationAddressPage> {
  late DroplocationBloc dropLocationBloc;
  @override
  void initState() {
    dropLocationBloc = BlocProvider.of<DroplocationBloc>(context);
    dropLocationBloc.initialLocation();
    super.initState();
    super.initState();
  }
  @override
  void dispose() {
    dropLocationBloc.cancelLocation();
    super.dispose();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: Stack(
          children: [
            CreateMap(),
            DropManualMarketMap()
          ],
        )
    );
  }
}
class CreateMap extends StatefulWidget {
  @override
  _CreateMapState createState() => _CreateMapState();
}

class _CreateMapState extends State<CreateMap> {
  Set<Marker> markers = {};
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {

    final mapLocation = BlocProvider.of<DroplocationBloc>(context);

    return BlocBuilder<DroplocationBloc, DroplocationState>(
        builder: (context, state)
        => ( state.existsLocation )
            ? GoogleMap(
          markers: Set<Marker>.from(markers),
          initialCameraPosition: CameraPosition(target: state.location!, zoom: 18),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          onCameraMove: (position) => mapLocation.add( OnMoveMapEvent( position.target ) ),
          onCameraIdle: (){
            if ( state.locationCentral != null ){
              mapLocation.add( OnGetAddressLocationEvent( mapLocation.state.locationCentral! ) );
            }
          },
        )
            : const Center(
          child: TextDapp(text: 'Locating...'),
        )
    );
  }

}

