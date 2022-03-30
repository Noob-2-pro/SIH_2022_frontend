import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_2022_sahaye/providers/authentication_provider.dart';
import 'package:sih_2022_sahaye/services/networking.dart';

import '../Models/user_model.dart';
class Authentication{
  final _auth=FirebaseAuth.instance;
  String? verificationId1;
  final DBPost post=DBPost();
  BuildContext? context;
  Future sendOtp( {required String phoneNumber})async{
    phoneNumber='+91'+phoneNumber.toString();
    try{
      _auth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: _onVerificationCompleted, verificationFailed: _onVerificationFailed, codeSent: _onCodeSent, codeAutoRetrievalTimeout: _onCodeTimeout);
    }
    catch(e)
    {
      throw(e.toString());
    }
  }
  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    debugPrint(authCredential.smsCode.toString());
    try{
      await FirebaseAuth.instance.currentUser!.linkWithCredential(authCredential);
    }
    catch(e)
    {
      debugPrint(e.toString());
    }

  }
  _onCodeSent(String verificationId, int? forceResendingToken) async {
    log(forceResendingToken.toString());
    verificationId1=verificationId;
  }
  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      log(exception.code);
    }
  }
  _onCodeTimeout(String timeout) {

    log(timeout);
    if(context!=null ) {
      Provider.of<AuthProvider>(context!,listen: false).setIsOtpTimeOut(true);
    }
    return null;
  }
 
  Future signUpRequest({required Map data}) async {
    var res = await post.sendRequest(
        data: data,
        headers1: {
          'Content-Type':'application/json',
        },
        url: "https://sahayaapp.herokuapp.com/api/signUp").catchError((error){
          throw (error);
    });
    //var encode=jsonEncode(res.toString());
    var decode=jsonDecode(res.toString());
    return decode;
  }
 
  Future loginRequest({required Map data}) async {
    print('hit');
    var res = await post.sendRequest(
        headers1: {
          'Content-Type':'application/json',
        },
        data: data,
        url: "https://sahayaapp.herokuapp.com/api/getUserFromPhone").catchError((error){
              throw (error);
    });
    //var encode=jsonEncode(res.toString());
    var decode=jsonDecode(res.toString());
    return decode;
  }
}