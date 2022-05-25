import 'dart:convert';

LocationModel userFromJson(String str) => LocationModel.fromJson(json.decode(str));

String userToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
     this.pickupAddress,
    this.dropoffAddress
  });

  String? pickupAddress;
String? dropoffAddress;


  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      pickupAddress: json["pickupAddress"],
    dropoffAddress: json["dropoffAddress"]
  );

  Map<String, dynamic> toJson() => {
    "pickupAddress": pickupAddress,
    "dropoffAddress": dropoffAddress
  };
}

