

import 'package:deliveryapp/Widgets/textDapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colorsDapp.dart';

void modalLoading(BuildContext context){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54, 
    builder: (context) 
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextDapp(text: 'Delivery', color: ColorsDapp.primaryColor, fontWeight: FontWeight.w500 ),
                  TextDapp(text: 'App', fontWeight: FontWeight.w500),
                ],
              ),
              Divider(),
              SizedBox(height: 10.0),
              Row(
                children: [
                  CircularProgressIndicator( color: ColorsDapp.primaryColor),
                  SizedBox(width: 15.0),
                  TextDapp(text: 'Loading...')
                ],
              ),
            ],
          ),
        ),
      ),
  );

}