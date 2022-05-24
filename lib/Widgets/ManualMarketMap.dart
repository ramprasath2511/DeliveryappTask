
import 'package:deliveryapp/Screen/create_order_page.dart';
import 'package:deliveryapp/Widgets/textDapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/MyLocation/mylocationmap_bloc.dart';
import 'AnimationRoute.dart';
import 'colorsDapp.dart';

class ManualMarketMap extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<MylocationmapBloc, MylocationmapState>(
        builder: (context, state)
        => ( state.existsLocation )
            ? _buildStackMarket(context)
            : Container()
    );
  }


  Widget _buildStackMarket(BuildContext context){

    final myLocationBloc = BlocProvider.of<MylocationmapBloc>(context);

    return Stack(
      children: [
        
        Positioned(
          top: 50,
          left: 20,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: ColorsDapp.primaryColor ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .75,  
                  padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 8),
                  margin: EdgeInsets.only(left: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
                    ]
                  ),
                  child: BlocBuilder<MylocationmapBloc, MylocationmapState>(
                      builder: (_, state)
                      => TextDapp(text: state.addressName, color: ColorsDapp.primaryColor, fontSize: 17 )
                  ),
                )
              ],
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, -15),
            child: Icon(Icons.location_on, size: 50)
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
          child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            minWidth: MediaQuery.of(context).size.width - 80,
            color: ColorsDapp.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: TextDapp(text: 'Confirm Address', color: Colors.white, fontSize: 17,),
            onPressed: (){
              if( myLocationBloc.state.addressName != '' ){
                Navigator.pushReplacement(context, routeDapp(page: CreatOrder("")));
               }
            },
          )
        )
      ],
    );
  }

}