import 'package:deliveryapp/Bloc/Auth/auth_bloc.dart';
import 'package:deliveryapp/Screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bloc/MyLocation/mylocationmap_bloc.dart';
import 'Screen/create_order_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getPref();
  }
late String email, password;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(create: (context) => MylocationmapBloc()),

    ],
     child:
     MaterialApp(
      title: 'Delivery App',
      home: Stack(
           children:[
        (_loginStatus == 1)? CreatOrder():LoginPage(),
         ]
      ),
    ),
    );
  }
var _loginStatus=0;
getPref() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  setState(() {
    _loginStatus = preferences.getInt("value")!;
  });
}
}


