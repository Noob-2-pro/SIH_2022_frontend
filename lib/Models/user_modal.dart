// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        this.latitude,
        this.longitude,
        this.id,
        this.firstName,
        this.lastName,
        this.phoneNo,
        this.gender,
        this.dateOfBirth,
        this.email,
        this.type,
        this.startTime,
        this.endTime,
        this.availability,
        this.slots,
        this.requestType,
        this.v,
    });

    final dynamic latitude;
    final dynamic longitude;
    final String? id;
    final String? firstName;
    final String? lastName;
    final String? phoneNo;
    final String? gender;
    final String? dateOfBirth;
    final String? email;
    final String? type;
    final String? startTime;
    final String? endTime;
    final String? availability;
    final int? slots;
    final String? requestType;
    final int? v;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        latitude: json["latitude"],
        longitude: json["longitude"],
        id: json["_id"] == null ? null : json["_id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
        gender: json["gender"] == null ? null : json["gender"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
        email: json["email"] == null ? null : json["email"],
        type: json["type"] == null ? null : json["type"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        availability: json["availability"] == null ? null : json["availability"],
        slots: json["slots"] == null ? null : json["slots"],
        requestType: json["requestType"] == null ? null : json["requestType"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "_id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phoneNo": phoneNo == null ? null : phoneNo,
        "gender": gender == null ? null : gender,
        "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
        "email": email == null ? null : email,
        "type": type == null ? null : type,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "availability": availability == null ? null : availability,
        "slots": slots == null ? null : slots,
        "requestType": requestType == null ? null : requestType,
        "__v": v == null ? null : v,
    };
}
