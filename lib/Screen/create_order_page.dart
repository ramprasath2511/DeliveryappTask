import 'package:cool_alert/cool_alert.dart';
import 'package:deliveryapp/Widgets/colorsDapp.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bloc/MyLocation/mylocationmap_bloc.dart';
import '../Widgets/AnimationRoute.dart';
import '../Widgets/buttonDapp.dart';
import '../Widgets/textDapp.dart';
import 'MapAddressPage.dart';
import 'login_page.dart';


class CreatOrder extends StatefulWidget {
  @override
  _CreatOrderState createState() => _CreatOrderState();
}

class _CreatOrderState extends State<CreatOrder> {

  final List VechicleType = [{
    'name':'Car','value':'100'},{
    'name':'Small Van','value':'150'},{
    'name':'Medium Van','value':'180'},{
    'name':'Luton Van','value':'200'},
  ];
  int activeCategory = 0;
  static const vat = 1.2;
  /*late TextEditingController _pickup;
  late TextEditingController _dropoff;*/
  String? selectedValue;
  double withvat = 0.00;double withoutvat = 0.00;
  late String pickupDetails;
  late String dropoffdetails;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  double? order ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final myLocationBloc = BlocProvider.of<MylocationmapBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsDapp.primaryColor,
        elevation: 0,
        title: TextDapp(text: "Create Order",fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        leadingWidth: 80,
        centerTitle: true,
        leading: InkWell(

          onTap: () {
            _savePref(0);
            },
          child: Row(
            children: const [
              SizedBox(width: 10.0),
              Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 17),
              TextDapp(text: 'Logout', fontSize: 16, color: Colors.white )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child:Column(
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

                        final permissionGPS = await Permission.location.isGranted;
                        final gpsActive = await Geolocator.isLocationServiceEnabled();

                        if( permissionGPS && gpsActive ){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapLocationAddressPage()));
                        }else {
                          Navigator.pop(context);
                        }

                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.centerLeft,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: BlocBuilder<MylocationmapBloc, MylocationmapState>(
                            builder: (_, state)
                            => TextDapp(text: state.addressName)
                        ),
                      ),
                    ),
                    /*TextFormField(
                      autocorrect: false,
                      controller: _pickup,
                      cursorColor: Colors.black,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return "Enter a PickupLocation";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        pickupDetails = val!;
                      },
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Enter Pick-up Location", border: InputBorder.none, suffixIcon: IconButton(
                          icon: Icon(Icons.my_location),
                          onPressed: () {}   ),),
                    ),*/
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
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
                              Text(
                                "Drop-Off Location",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xff67727d)),
                              ),
                              InkWell(
                                onTap: () async {

                                  final permissionGPS = await Permission.location.isGranted;
                                  final gpsActive = await Geolocator.isLocationServiceEnabled();
/*

                                  if( permissionGPS && gpsActive ){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MapLocationAddressPage()),
                                    );
                                  }else {
                                    Navigator.pop(context);
                                  }
*/

                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(5.0)
                                  ),
                                  child: BlocBuilder<MylocationmapBloc, MylocationmapState>(
                                      builder: (_, state)
                                      => TextDapp(text: state.addressName)
                                  ),
                                ),
                              ),/*BlocBuilder<MylocationmapBloc, MylocationmapState>(
                            builder: (_, state)
                            => TextFormField(
                                controller: _dropoff,
                                cursorColor: Colors.black,
                                validator: (val) {
                                  if(val!.isEmpty) {
                                    return "Select Drop-off location";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  dropoffdetails = val! ;
                                },
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Enter Drop-off location",
                                    border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.my_location),
                                      onPressed: ()  async {
                                        final permissionGPS = await Permission.location.isGranted;
                                        final gpsActive = await Geolocator.isLocationServiceEnabled();
                                        if( permissionGPS && gpsActive ){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => MapLocationAddressPage()),
                                          );
                                        }else {
                                          Navigator.pop(context);
                                        }

                                      },  ),),
                              ),),*/

                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        style: TextStyle(fontSize: 14,
                            color: Colors.black45),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorsDapp.primaryColor,
                      ),
                      items: VechicleType.map((item) => DropdownMenuItem(
                        value: item['value'],
                        child: Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select the vehicle';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                          double result  =  ((int.parse(selectedValue!)) * 32)/100;
                          withvat = result*vat;
                          withoutvat =result/vat;
                          print(result);
                        });
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Text(
                              "Total price (without VAT)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                           Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "£"+withoutvat.toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Text(
                              "Total price (with VAT)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "£"+withvat.toStringAsFixed(2),
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
                    SizedBox(
                      height: 40,
                    ),
                    ButtonDapp(
                      text: 'Order',
                      fontSize: 21,
                      height: 50,
                      fontWeight: FontWeight.w500, color: ColorsDapp.primaryColor,
                      onPressed: () {
                        if( _formKey.currentState!.validate() ){
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Your order was successful!",
                            autoCloseDuration: const Duration(seconds: 3),
                            backgroundColor: ColorsDapp.primaryColor,
                              confirmBtnColor: ColorsDapp.primaryColor,

                          );
                        }
                      },
                    ),
    ],
    ),
    ),
    ]),
    ),
    ),
    );
  }
  _savePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.commit();
  }

}