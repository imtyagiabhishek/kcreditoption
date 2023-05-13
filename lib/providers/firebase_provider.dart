import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';



class FirebaseProvider extends GetxService {
  fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

  String verificationid="";
  bool? verifiedPhone;
  Future<FirebaseProvider> init() async {
    return this;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      fba.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return await signUpWithEmailAndPassword(email, password);
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    fba.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (result.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyPhone(String smsCode) async {
    try {
      verificationid=await getVerificationID();
      final fba.AuthCredential credential = fba.PhoneAuthProvider.credential(verificationId: verificationid, smsCode: smsCode);
      await fba.FirebaseAuth.instance.signInWithCredential(credential);
      verifiedPhone = true;
    } catch (e) {
     verifiedPhone= false;
      throw Exception(e.toString());
    }
    return verifiedPhone!;
  }
  Future<bool> setVerificationID(String verificationID) async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    return await sharedPreferences.setString(AppConstants.VERIFICATIONID, verificationID);
  }
  Future<String> getVerificationID() async {
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.VERIFICATIONID) ?? "";
  }
  Future<void> sendCodeToPhone(String phoneNo) async {
    verificationid= '';
    final fba.PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {};
    final fba.PhoneCodeSent smsCodeSent = (String verId, [ int? forceCodeResent]) {verificationid=verId;
      setVerificationID(verificationid);};
    final fba.PhoneVerificationCompleted _verifiedSuccess = (fba.AuthCredential auth) async {};
    final fba.PhoneVerificationFailed _verifyFailed = (fba.FirebaseAuthException e) {
      throw Exception(e.message);
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: _verifiedSuccess,
      verificationFailed: _verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future signOut() async {
    return await _auth.signOut();
  }
}
