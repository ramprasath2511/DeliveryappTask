import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/MyLocation/mylocationmap_bloc.dart';
import '../Widgets/ManualMarketMap.dart';
import '../Widgets/textDapp.dart';

class StartLocationAddressPage extends StatefulWidget {
  @override
  _StartLocationAddressPageState createState() => _StartLocationAddressPageState();
}
class _StartLocationAddressPageState extends State<StartLocationAddressPage> {
  late MylocationmapBloc mylocationmapBloc;
  @override
  void initState() {
    mylocationmapBloc = BlocProvider.of<MylocationmapBloc>(context);
    mylocationmapBloc.initialLocation();
    super.initState();
    super.initState();
  }
  @override
  void dispose() {
    mylocationmapBloc.cancelLocation();
    super.dispose();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: Stack(
          children: [
            CreateMap(),
            ManualMarketMap()
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

    final mapLocation = BlocProvider.of<MylocationmapBloc>(context);

    return BlocBuilder<MylocationmapBloc, MylocationmapState>(
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

