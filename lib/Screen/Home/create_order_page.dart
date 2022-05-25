import 'dart:math';

import 'package:deliveryapp/Screen/DropoffAddress/DropMapAddressPage.dart';
import 'package:deliveryapp/Widgets/colorsDapp.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Bloc/DropLocation/droplocation_bloc.dart';
import '../../Bloc/MyLocation/mylocationmap_bloc.dart';
import '../../Widgets/buttonDapp.dart';
import '../../Widgets/textDapp.dart';
import '../Login/login_page.dart';
import '../PickupAddress/StartMapAddressPage.dart';
import '../../Services/Utils.dart';
import 'package:cool_alert/cool_alert.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  _CreateOrderState createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final List VechicleRates = [
    {'name': 'Car', 'value': '100'},
    {'name': 'Small Van', 'value': '150'},
    {'name': 'Medium Van', 'value': '180'},
    {'name': 'Luton Van', 'value': '200'},
  ];
  int activeCategory = 0;
  static const vat = 1.2;
  String? selectedValue;
  double withVat = 0.00;
  double withoutVat = 0.00;
  final _formKey = GlobalKey<FormState>();
  String? _placeDistance;
  static const apiKey = Utils.API_KEY;
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
  }

  double? order;

  @override
  Widget build(BuildContext context) {
    final dropLocationBloc = BlocProvider.of<DroplocationBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsDapp.primaryColor,
        elevation: 0,
        title: const TextDapp(
            text: "Create Order",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        leadingWidth: 80,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            _savePref(0);
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => LoginPage()), ModalRoute.withName("/login_page"));
          },
          child: Row(
            children: const [
              SizedBox(width: 10.0),
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 17),
              TextDapp(text: 'Logout', fontSize: 16, color: Colors.white)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pickup Location",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xff67727d)),
                      ),
                      InkWell(
                        onTap: () async {
                          final permissionGPS =
                              await Permission.location.isGranted;
                          final gpsActive =
                              await Geolocator.isLocationServiceEnabled();

                          if (permissionGPS && gpsActive) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StartLocationAddressPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Your GPS is switched-off'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: BlocBuilder<MylocationmapBloc,
                                  MylocationmapState>(
                              builder: (_, state) => TextDapp(
                                  text: state.addressName,
                                  color: ColorsDapp.primaryColor,
                                  fontSize: 17)),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (size.width - 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Drop-Off Location",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xff67727d)),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final permissionGPS =
                                          await Permission.location.isGranted;
                                      final gpsActive = await Geolocator
                                          .isLocationServiceEnabled();
                                      if (permissionGPS && gpsActive) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DropLocationAddressPage()),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Your GPS is switched-off'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: BlocBuilder<DroplocationBloc,
                                          DroplocationState>(
                                        builder: (_, state) => TextDapp(
                                            text: state.addressName,
                                            color: ColorsDapp.primaryColor,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Visibility(
                                          visible: _placeDistance == null
                                              ? false
                                              : true,
                                          child: Text(
                                            'DISTANCE: $_placeDistance km',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(height: 15),
                                  DropdownButtonFormField2(
                                    value: selectedValue,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey,
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select the vehicle',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black45),
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 30,
                                    buttonHeight: 60,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ColorsDapp.primaryColor,
                                    ),
                                    items: VechicleRates.map(
                                        (item) => DropdownMenuItem(
                                              value: item['value'],
                                              child: Text(
                                                item['name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select the vehicle';
                                      }
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value.toString();
                                      });
                                    },
                                    onSaved: (value) {
                                      selectedValue = value.toString();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 80),
                                          child: Text(
                                            "Total price (without VAT)",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "£" + withoutVat.toStringAsFixed(2),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 80),
                                          child: Text(
                                            "Total price (with VAT)",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "£" + withVat.toStringAsFixed(2),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  BlocBuilder<MylocationmapBloc,
                                      MylocationmapState>(
                                    builder: (_, state) => ButtonDapp(
                                      text: 'Calculate Travel Price',
                                      fontSize: 21,
                                      height: 50,
                                      fontWeight: FontWeight.w500,
                                      color: ColorsDapp.primaryColor,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            if (polylines.isNotEmpty)
                                              polylines.clear();
                                            if (polylineCoordinates.isNotEmpty)
                                              polylineCoordinates.clear();
                                            _placeDistance = null;
                                          });
                                          calculateDistance(
                                                  state.locationCentral!
                                                      .latitude,
                                                  state.locationCentral!
                                                      .longitude,
                                                  dropLocationBloc
                                                      .state
                                                      .locationCentral!
                                                      .latitude,
                                                  dropLocationBloc
                                                      .state
                                                      .locationCentral!
                                                      .longitude)
                                              .then((isCalculated) {
                                            if (isCalculated) {
                                              double result = ((int.parse(
                                                          selectedValue!) *
                                                      num.parse(
                                                          _placeDistance!))) /
                                                  100;
                                              withVat = result * vat;
                                              withoutVat = result / vat;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Distance Calculated Successfully'),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Error Calculating Distance'),
                                                ),
                                              );
                                            }
                                          });

                                           CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Calculated your order successful!",
                            autoCloseDuration: const Duration(seconds: 4),
                            backgroundColor: ColorsDapp.primaryColor,
                              confirmBtnColor: ColorsDapp.primaryColor,
                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _savePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.commit();
  }

  Future<bool> calculateDistance(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude) async {
    try {
      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

// Create the polylines for showing the route between two places
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }
}
