import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class DBPost{
  Future sendRequest({data,headers,url}) async {
    final res = await http.post(Uri.parse(url),
      body: jsonEncode(data),
    ).catchError((error) {
      throw(error);
    });
    debugPrint(res.body.toString());
    return res.body.toString();

  }
}