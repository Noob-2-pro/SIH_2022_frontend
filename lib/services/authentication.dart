import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_2022_sahaye/services/post_requests.dart';
class Authentication{
  final _auth=FirebaseAuth.instance;
  String? verificationId1;
  bool isOtpTimeout=false;
  final DBPost post=DBPost();
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
    isOtpTimeout=true;
    return null;
  }
  Future signUpRequest({required Map data}) async {
    var res = await post.sendRequest(headers: {},
        data: data,
        url: "http://sahayaapp.herokuapp.com/api/signUp");
    var decode=jsonDecode(res);
    return decode;
  }
  Future loginRequest({required Map data}) async {
      var res = await post.sendRequest(headers: {},
          data: data,
          url: "http://sahayaapp.herokuapp.com/api/getUserFromPhone");
      var decode=jsonDecode(res);
      return decode;
    }
}