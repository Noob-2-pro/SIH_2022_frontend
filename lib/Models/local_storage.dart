import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class UserModel{
  /*final storage = new FlutterSecureStorage();
  String id = result1["data"]['id_cust'].toString();*/
  final storage = const FlutterSecureStorage();
  Future getUserType()async{
    var res=await storage.read(key:'user_type');
    return res;
  }
  Future deleteUserId() async {
    storage.delete(key: 'user_type');
  }
}