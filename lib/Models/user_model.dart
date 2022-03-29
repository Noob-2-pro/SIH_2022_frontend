// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.id,
    required this.firstName,
    required this.lastName,
    required  this.phoneNo,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.availability,
    required this.latitude,
    required this.longitude,
    required this.slots,
    required this.requestType,
    required this.v,
  });

  String id;
  String firstName;
  String lastName;
  String phoneNo;
  String gender;
  String dateOfBirth;
  String email;
  String type;
  dynamic startTime;
  dynamic endTime;
  String availability;
  dynamic latitude;
  dynamic longitude;
  int slots;
  String requestType;
  int v;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNo: json["phoneNo"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    email: json["email"],
    type: json["type"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    availability: json["availability"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    slots: json["slots"],
    requestType: json["requestType"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNo": phoneNo,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "email": email,
    "type": type,
    "startTime": startTime,
    "endTime": endTime,
    "availability": availability,
    "latitude": latitude,
    "longitude": longitude,
    "slots": slots,
    "requestType": requestType,
    "__v": v,
  };
}
