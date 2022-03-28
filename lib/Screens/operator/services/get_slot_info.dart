import 'dart:convert';
import 'package:sih_2022_sahaye/Screens/operator/services/slot_info_modal.dart';
import '../../../services/networking.dart';

class SlotData {
  final DBPost networking = DBPost();

  Future<List<SlotInfo>> getSlotData({required Map data}) async {
    String response = await networking
        .sendRequest(
            data: data,
            headers1: {
              'Content-Type': 'application/json',
            },
            url: "https://sahayaapp.herokuapp.com/api/slots/getAllSlots")
        .catchError((error) {
      throw error;
    });

    Iterable l = json.decode(response);
    List<SlotInfo> slotdata = List<SlotInfo>.from(l.map((model) => SlotInfo.fromJson(model)));
    return slotdata;
    // return list;
    // Map peopleData = jsonDecode(response.body);
    // List<dynamic> peoples = peopleData["results"];
    // return peoples.map((json) => Person.fromJson(json)).toList();
  }
}
