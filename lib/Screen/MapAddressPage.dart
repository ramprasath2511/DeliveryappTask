import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/MyLocation/mylocationmap_bloc.dart';
import '../Widgets/ManualMarketMap.dart';
import '../Widgets/textDapp.dart';


class MapLocationAddressPage extends StatefulWidget {
  @override
  _MapLocationAddressPageState createState() => _MapLocationAddressPageState();
}

class _MapLocationAddressPageState extends State<MapLocationAddressPage> {

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
            _CreateMap(),
            ManualMarketMap()
          ],
        )
    );
  }
}

class _CreateMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mapLocation = BlocProvider.of<MylocationmapBloc>(context);
    return BlocBuilder<MylocationmapBloc, MylocationmapState>(
        builder: (context, state)
        => ( state.existsLocation )
            ? GoogleMap(
          initialCameraPosition: CameraPosition(target: state.location!, zoom: 18),
          zoomControlsEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: mapLocation.initMapLocation,
         // onCameraMove: (position) =>mapLocation.add( OnMoveMapEvent( position.target ) ),
          onCameraIdle: (){
            if ( state.locationCentral != null ){
              mapLocation.add( OnGetAddressLocationEvent( mapLocation.state.location! ) );
            }
          },
        )
            : const Center(
          child: TextDapp(text: 'Locating...'),
        )
    );
  }


  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

}
