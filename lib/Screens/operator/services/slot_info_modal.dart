// To parse this JSON data, do
//
//     final slotInfo = slotInfoFromJson(jsonString);

import 'dart:convert';

List<SlotInfo> slotInfoFromJson(String str) => List<SlotInfo>.from(json.decode(str).map((x) => SlotInfo.fromJson(x)));

String slotInfoToJson(List<SlotInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlotInfo {
    SlotInfo({
        this.userFirstName,
        this.id,
        this.operatorId,
        this.userId,
        this.startTime,
        this.endTime,
        this.date,
        this.availability,
        this.userLatitude,
        this.userLongitude,
        this.operatorLatitude,
        this.operatorLongitude,
        this.requestType,
        this.status,
        this.v,
    });

    final dynamic userFirstName;
    final String? id;
    final String? operatorId;
    final dynamic userId;
    final String? startTime;
    final String? endTime;
    final dynamic date;
    final String? availability;
    final dynamic userLatitude;
    final dynamic userLongitude;
    final String? operatorLatitude;
    final String? operatorLongitude;
    final dynamic requestType;
    final dynamic status;
    final int? v;

    factory SlotInfo.fromJson(Map<String, dynamic> json) => SlotInfo(
        userFirstName: json["userFirstName"],
        id: json["_id"] == null ? null : json["_id"],
        operatorId: json["operatorID"] == null ? null : json["operatorID"],
        userId: json["userID"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        date: json["date"],
        availability: json["availability"] == null ? null : json["availability"],
        userLatitude: json["userLatitude"],
        userLongitude: json["userLongitude"],
        operatorLatitude: json["operatorLatitude"] == null ? null : json["operatorLatitude"],
        operatorLongitude: json["operatorLongitude"] == null ? null : json["operatorLongitude"],
        requestType: json["requestType"],
        status: json["status"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userFirstName": userFirstName,
        "_id": id == null ? null : id,
        "operatorID": operatorId == null ? null : operatorId,
        "userID": userId,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "date": date,
        "availability": availability == null ? null : availability,
        "userLatitude": userLatitude,
        "userLongitude": userLongitude,
        "operatorLatitude": operatorLatitude == null ? null : operatorLatitude,
        "operatorLongitude": operatorLongitude == null ? null : operatorLongitude,
        "requestType": requestType,
        "status": status,
        "__v": v == null ? null : v,
    };
}
