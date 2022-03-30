// To parse this JSON data, do
//
//     final opmodal = opmodalFromJson(jsonString);

import 'dart:convert';

List<Opmodal> opmodalFromJson(String str) => List<Opmodal>.from(json.decode(str).map((x) => Opmodal.fromJson(x)));

String opmodalToJson(List<Opmodal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Opmodal {
    Opmodal({
        this.operatorId,
        this.firstName,
        this.latitude,
        this.longitude,
        this.availability,
    });

    final String? operatorId;
    final String? firstName;
    final String? latitude;
    final String? longitude;
    final String? availability;

    factory Opmodal.fromJson(Map<String, dynamic> json) => Opmodal(
        operatorId: json["OperatorID"],
        firstName: json["firstName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        availability: json["availability"],
    );

    Map<String, dynamic> toJson() => {
        "OperatorID": operatorId,
        "firstName": firstName,
        "latitude": latitude,
        "longitude": longitude,
        "availability": availability,
    };
}
