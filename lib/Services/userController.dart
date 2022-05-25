import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:deliveryapp/Models/message_model.dart';
import 'package:deliveryapp/Services/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user_model.dart';
class UserController{
  Future<String?>? loginController( String email, String password ) async {

    final response = await http.post(Uri.parse('${Utils.URL_API}/user/authenticate'),
        headers: { 'Accept' : 'application/json' },
        body: {
          'email' : email,
          'password' : password
        }
    );
    if (response.statusCode == 200) {
      _savePref(1,"email");
        return null ;
    }else {
      var messageData = MessageModel.fromJson( jsonDecode( response.body) );
      return messageData.message;
    }
    return response.body;
  }
  _savePref(int value, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.getString("email");
    preferences.commit();

  }
}