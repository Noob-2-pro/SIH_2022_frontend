import 'dart:convert';
import 'package:sih_2022_sahaye/Models/user_modal.dart';
import '../constants.dart';
import 'networking.dart';

class User {
  final DBPost networking = DBPost();

  Future<UserData> getUserData({required Map data}) async {
    String response = await networking
        .sendRequest(
            data: data,
            headers1: {
              'Content-Type': 'application/json',
            },
            url: "http://sahayaapp.herokuapp.com/api/user/getUserInfo")
        .catchError((error) {
      throw error;
    });

    final decodedData = jsonDecode(response);
    final userData = UserData.fromJson(decodedData);
    return userData;
  }
}
