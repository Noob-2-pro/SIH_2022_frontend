import 'package:flutter/cupertino.dart';
class AuthProvider with ChangeNotifier{
  bool isOtpTimeOut=false;
   setIsOtpTimeOut(value){
    isOtpTimeOut=value;
    notifyListeners();
  }
  get getIsOtpTimeOut{
    return isOtpTimeOut;
  }
}