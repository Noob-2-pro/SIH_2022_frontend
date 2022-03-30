import 'dart:convert';
import 'package:sih_2022_sahaye/Screens/admin/op_modal.dart';
import '../../../services/networking.dart';

class OPLocData {
  final DBPost networking = DBPost();

  Future<List<Opmodal>> getOPLocation({required Map data}) async {
    String response = await networking
        .sendRequest(
            data: data,
            headers1: {
              'Content-Type': 'application/json',
            },
            url: "https://sahayaapp.herokuapp.com/api/user/getOperatorLocation")
        .catchError((error) {
      throw error;
    });

    var l = json.decode(response);
    List<Opmodal> opData = List<Opmodal>.from(l.map((model) => Opmodal.fromJson(model)));
    return opData;
  }
}
