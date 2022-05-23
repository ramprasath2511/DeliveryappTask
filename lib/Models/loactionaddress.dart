import 'dart:convert';

LocationModel userFromJson(String str) => LocationModel.fromJson(json.decode(str));

String userToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
     this.startAddress,
    this.endAddress
  });

  String? startAddress;
String? endAddress;


  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      startAddress: json["startAddress"],
    endAddress: json["endAddress"]
  );

  Map<String, dynamic> toJson() => {
    "startAddress": startAddress,
    "endAddress": endAddress
  };
}

