import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class DBPost{
  Future sendRequest({data,headers1,url}) async {
    final res = await http.post(
        Uri.parse(url),
      body: jsonEncode(data),
      headers: headers1
    );
    //debugPrint(res.body.toString());
    if(res.statusCode==404)
      {    print('error4');
        throw( res.body.toString());
      }
    else if(res.statusCode==503)
      {   print('error5');
        throw(res.body.toString());
      }

    return res.body.toString();

  }
}