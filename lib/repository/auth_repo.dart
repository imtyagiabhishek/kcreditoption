import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditoption/model/request/bank_income_request.dart';
import 'package:kreditoption/model/request/insurance_request.dart';
import 'package:kreditoption/model/request/kyc_details_request.dart';
import 'package:kreditoption/model/request/loan_apply_request.dart';
import 'package:kreditoption/model/request/personal_details_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../providers/firebase_provider.dart';
import '../utils/app_constants.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({ required this.apiClient, required this.sharedPreferences});


  Future<Response> login({ String? phone,String? deviceToken}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"loginId": phone,"deviceId": deviceToken});
  }
  Future<Response> sendEmail({ String? email,String? name,String? subject,String? body}) async {
    return await apiClient.postEmailData( {"sender_name": name,"sender_email": email,"receiver_email": AppConstants.APP_EMAIL,"subject": subject,"mail_body": body});
  }
  Future<Response> loanApply({ LoanApplyRequest? loanApplyRequest}) async {
    return await apiClient.postData(AppConstants.LOAN_APPLY, loanApplyRequest);
  }
  Future<Response> loanUpdate({ LoanApplyRequest? loanApplyRequest,String? loanId}) async {
    return await apiClient.patchData(AppConstants.LOAN_UPDATE+loanId!, loanApplyRequest);
  }
  Future<Response> personalDetails({ PersonalDetailsRequest? personalDetailsRequest,String? loanId}) async {
    return await apiClient.patchData(AppConstants.PERSONAL_DETAILS+loanId!, personalDetailsRequest);
  }
  Future<Response> kycDetails({ KYCDetailsRequest? kycDetailsRequest,String? loanId}) async {
    return await apiClient.patchData(AppConstants.KYC_DETAILS+loanId!, kycDetailsRequest);
  }
  Future<Response> bankIncomeDetails({ BankIncomeDetailsRequest? bankIncomeDetailsRequest,String? loanId}) async {
    return await apiClient.patchData(AppConstants.INCOME_DETAILS+loanId!, bankIncomeDetailsRequest);
  }
  Future<Response> insuranceDetails({ InsuranceDetailsRequest? insuranceDetailsRequest,String? loanId}) async {
    return await apiClient.patchData(AppConstants.INSURANCE_DETAILS+loanId!, insuranceDetailsRequest);
  }
  Future<Response> getprofile(String? id) async {
    return await apiClient.getData(AppConstants.UPDATE_USER_URI+id!);
  }
  Future<Response> getMenu() async {
    return await apiClient.getData(AppConstants.MENU_URI);
  }
  Future<Response> getLoanById(String loanId) async {
    return await apiClient.getData(AppConstants.LOAN_DETAILS_URI+loanId);
  }
  Future<Response> getBankDetails() async {
    return await apiClient.getData(AppConstants.ADMIN_BANK_URI);
  }
  Future<Response> getLoan() async {
    return await apiClient.getData(AppConstants.LOAN_PANEL_LIST_URI);
  }
  Future<Response> getLoanType() async {
    return await apiClient.getData(AppConstants.LOAN_TYPE_URI);
  }
  Future<Response> getNotification() async {
    return await apiClient.getData(AppConstants.Notification_URI);
  }
  Future<Response> getLoanSteps({String? id,String? step}) async {
    return await apiClient.putData(AppConstants.LOAN_STEPS_URI+id!,{"step": step});
  }

  Future<Response> uploadImage(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.PERSONAL_DETAILS+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadImageAadharFront(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.KYC_DETAILS_AADHAR_FRONT+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadImageAadharBack(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.KYC_DETAILS_AADHAR_BACK+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadImagePanFront(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.KYC_DETAILS_PAN_FRONT+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadCharge(XFile data,String loanID) async {
    return await apiClient.postImageData2(AppConstants.PAYMENT_HISTORY_CHARGE_URI+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadRePayment(XFile data,String loanID,String emiID) async {
    return await apiClient.postImageData2(AppConstants.PAYMENT_HISTORY_EMI_URI+loanID+"/"+emiID,MultipartBody('file', data));
  }
  Future<Response> uploadCREDITSCORE(XFile data,String loanID,String creditScore) async {
    return await apiClient.postImageData2(AppConstants.UPLOAD_CREDIT_SCORE_URI+loanID+"/"+creditScore,MultipartBody('file', data));
  }
  Future<Response> uploadCREDITSCOREGET(String loanID) async {
    return await apiClient.getData(AppConstants.UPLOAD_CREDIT_SCORE_URI+loanID);
  }
  Future<Response> uploadImagePanBack(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.KYC_DETAILS_PAN_BACK+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadImagePassBook(XFile data,String loanID) async {
    return await apiClient.postImageData(
        AppConstants.KYC_DETAILS_PASSBOOK + loanID, MultipartBody('file', data));
  }
  Future<Response> uploadImageSalarySlip(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.KYC_DETAILS_SLIP+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadImageReceipt(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.PERSONAL_DETAILS+loanID,MultipartBody('file', data));
  }
  Future<Response> uploadImageSignature(XFile data,String loanID) async {
    return await apiClient.postImageData(AppConstants.SIGNATURE_DETAILS+loanID,MultipartBody('file', data));
  }
 /* Future<Response> setMenuClick(int menuListId,String deviceID) async {
    return await apiClient.postData(AppConstants.MENU_CLICK_URI,{"deviceId": deviceID, "menuListId": menuListId});
  }
*/






  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
   // apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
  Future<bool> saveUserLoanID(String loanId) async {
    return await sharedPreferences.setString(AppConstants.LOAN_ID, loanId);
  }

  String getUserLoanID() {
    return sharedPreferences.getString(AppConstants.LOAN_ID) ?? "";
  }
  String getLoanCharge() {
    return sharedPreferences.getString(AppConstants.LOAN_Charge) ?? "0";
  }
  String getUserLoanType() {
    return sharedPreferences.getString(AppConstants.LOAN_Type) ?? "";
  }
  String getCreditStatus() {
    return sharedPreferences.getString(AppConstants.CREDIT_STATUS) ?? "0";
  }
  Future<bool> saveLoanStatus(String loanstatus) async {
    return await sharedPreferences.setString(AppConstants.LOAN_STATUS, loanstatus);
  }
  Future<bool> saveLoanCharge(String loanCharge) async {
    return await sharedPreferences.setString(AppConstants.LOAN_Charge, loanCharge);
  } Future<bool> saveLoanType(String loanType) async {
    return await sharedPreferences.setString(AppConstants.LOAN_Type, loanType);
  }
  Future<bool> savePaymentStatus(String paymentStatus) async {
    return await sharedPreferences.setString(AppConstants.PAYMENT_STATUS, paymentStatus);
  }
  Future<bool> saveCreditStatus(String creditStatus) async {
    return await sharedPreferences.setString(AppConstants.CREDIT_STATUS, creditStatus);
  }
  String getLoanStatus() {
    return sharedPreferences.getString(AppConstants.LOAN_STATUS) ?? "0";
  }
  String getPaymentStatus() {
    return sharedPreferences.getString(AppConstants.PAYMENT_STATUS) ?? "0";
  }
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
   /* if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
      apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "cm_firebase_token": '@'});
    }*/
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.login);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }
  String getLogin() {
    return sharedPreferences.getString(AppConstants.login) ?? "0";
  }
  Future<bool> SetLogin(String login) async{
    return await sharedPreferences.setString(AppConstants.login, login);
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }
  Future<bool> SetUserNumber(String phone) async{
    return await sharedPreferences.setString(AppConstants.USER_NUMBER, phone);
  }

  Future<bool> setUserID(String userID) async{
    return await sharedPreferences.setString(AppConstants.USERID, userID);
  }
  Future<bool> setDeviceID(String deiceID) async{
    return await sharedPreferences.setString(AppConstants.DEVICEID, deiceID);
  }
  String getDeviceID() {
    return sharedPreferences.getString(AppConstants.DEVICEID) ?? "";
  }

  String getUser() {
    return sharedPreferences.getString(AppConstants.USERID) ?? "";
  }
  String getUserID() {
    return sharedPreferences.getString(AppConstants.USERID) ?? "";
  }


  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }
  Future<bool> verifyPhone(String smsCode) async {
    FirebaseProvider _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.verifyPhone(smsCode);
  }

  Future<void> sendCodeToPhone(String PhoneNo) async {
    FirebaseProvider _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.sendCodeToPhone(PhoneNo);
  }
  Future<bool> setFirst(String first_time) async{
    return await sharedPreferences.setString(AppConstants.first_time, first_time);
  }
  String isfirst() {
    return sharedPreferences.getString(AppConstants.first_time) ?? "0";
  }
}
