import 'dart:convert';

import 'networking.dart';

class UserServices{
  final DBPost post=DBPost();
  Future getUserSlot({required Map data})async{
    var res = await post.sendRequest(
        data: data,
        headers1: {
          'Content-Type':'application/json',
        },
        url: "https://sahayaapp.herokuapp.com/api/slots/getSlotByID").catchError((error){
      throw (error);
    });
    var encode=jsonEncode(res.toString());
    var decode=jsonDecode(res.toString());
    return decode;
  }
  Future bookSlot({required Map data})async{
    var res = await post.sendRequest(
        data: data,
        headers1: {
          'Content-Type':'application/json',
        },
        url: "https://sahayaapp.herokuapp.com/api/slots/BookSlot").catchError((error){
      throw (error);
    });
    //var encode=jsonEncode(res.toString());
    var decode=jsonDecode(res.toString());
    return decode;
  }
  Future feedBack({required Map data}) async {
    var res = await post.sendRequest(
        data: data,
        headers1: {
          'Content-Type':'application/json',
        },
        url: "https://sahayaapp.herokuapp.com/api/feedback/fillFeedback").catchError((error){
      throw (error);
    });
   // var encode=jsonEncode(res.toString());
    var decode=jsonDecode(res.toString());
    return decode;
  }

}