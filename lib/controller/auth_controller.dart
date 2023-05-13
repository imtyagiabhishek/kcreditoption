import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditoption/model/apply_loan_model.dart';
import 'package:kreditoption/model/apply_loan_model_response.dart';
import 'package:kreditoption/model/bni_model.dart';
import 'package:kreditoption/model/insurance_model.dart';
import 'package:kreditoption/model/kyc_details.dart';
import 'package:kreditoption/model/menu_model.dart';
import 'package:kreditoption/model/notification_model.dart';
import 'package:kreditoption/model/personal_details.dart';
import 'package:kreditoption/model/request/bank_income_request.dart';
import 'package:kreditoption/model/request/insurance_request.dart';
import 'package:kreditoption/model/request/kyc_details_request.dart';
import 'package:kreditoption/model/request/loan_apply_request.dart';
import 'package:kreditoption/model/request/personal_details_request.dart';
import 'package:kreditoption/pages/login_screen.dart';
import 'package:kreditoption/pages/otp_screen.dart';
import '../model/bank_model.dart';
import '../model/login_response.dart';
import '../model/response_model.dart';
import '../pages/option_screen.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _notification = true;
  bool _acceptTerms = true;
  bool get isLoading => _isLoading;
  ApplyLoanModel _appplyloanmodel = ApplyLoanModel();
  BankModel _bankModel = BankModel();
  BankModel get bankModel => _bankModel;
  ApplyLoanModel get appplyloanmodel => _appplyloanmodel;
  bool get notification => _notification;
  bool get acceptTerms => _acceptTerms;
  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;
  void register(String phoneNo, BuildContext context) async {
    try {
      await authRepo.sendCodeToPhone("+91" + phoneNo);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OTPScreen(phone: phoneNo)));
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 3),
        backgroundColor: true ? Colors.red : Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {}
  }

  void verifyPhone(String smsCode, String phone, BuildContext context) async {
    try {
      await authRepo.verifyPhone(smsCode).then((value) async {
        if (value) {
          login(phone, context);
        } else {
          var snackBar = const SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 3),
            backgroundColor: true ? Colors.red : Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 3),
        backgroundColor: true ? Colors.red : Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {}
  }

  Future<ResponseModel> login(String phone, BuildContext context) async {
    _isLoading = true;
    String? token = await FirebaseMessaging.instance.getToken();

    Response response = await authRepo.login(phone: phone, deviceToken: token);
    ResponseModel responseModel;
    if (response.statusCode == 201) {
      LoginResponse loginResponse = LoginResponse();
      loginResponse = LoginResponse.fromJson(response.body);
      authRepo.saveUserToken(loginResponse.token!);
      authRepo.SetLogin("1");
      responseModel = ResponseModel(true, "");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OptionScreen()));
    } else {
      var snackBar = const SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<Response> sendEmail(String email, String name, String subject,
      String body, BuildContext context) async {
    _isLoading = true;
    Response response = await authRepo.sendEmail(
        email: email, name: name, subject: subject, body: body);

    if (response.statusCode == 200) {
      var snackBar = const SnackBar(
          content: Text("Email Sent"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var snackBar = const SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<ApplyLoanResponse> loanApply(
      LoanApplyRequest loanApplyRequest, BuildContext context) async {
    _isLoading = true;
    ApplyLoanResponse loginResponse = ApplyLoanResponse();
    Response response =
        await authRepo.loanApply(loanApplyRequest: loanApplyRequest);
    ResponseModel responseModel;
    if (response.statusCode == 201) {
      saveUserLoanStatus("0");
      loginResponse = ApplyLoanResponse.fromJson(response.body);
      authRepo.saveUserLoanID(loginResponse.id!);
      responseModel = ResponseModel(true, "");
    } else {
      var snackBar = SnackBar(
          content: Text(response.body['message']),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return loginResponse;
  }

  Future<ApplyLoanResponse> loanUpdate(LoanApplyRequest loanApplyRequest,
      String? loanId, BuildContext context) async {
    _isLoading = true;
    ApplyLoanResponse loginResponse = ApplyLoanResponse();
    Response response = await authRepo.loanUpdate(
        loanApplyRequest: loanApplyRequest, loanId: loanId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      saveUserLoanStatus("0");
      loginResponse = ApplyLoanResponse.fromJson(response.body);
      authRepo.saveUserLoanID(loginResponse.id!);
      responseModel = ResponseModel(true, "");
    } else {
      var snackBar = const SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return loginResponse;
  }

  Future<PersonalDetail> personalDetails(
      PersonalDetailsRequest personalDetailsRequest,
      String? loanId,
      BuildContext context) async {
    _isLoading = true;
    PersonalDetail loginResponse = PersonalDetail();
    Response response = await authRepo.personalDetails(
        personalDetailsRequest: personalDetailsRequest, loanId: loanId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await authRepo.getLoanSteps(id: loanId, step: "Personal Details");
      loginResponse = PersonalDetail.fromJson(response.body);
      responseModel = ResponseModel(true, "");
    } else {
      var snackBar = const SnackBar(
          content: Text("Please fill all field correctly"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return loginResponse;
  }

  Future<KycDetail> kycDetails(KYCDetailsRequest kycDetailsRequest,
      String? loanId, BuildContext context) async {
    _isLoading = true;
    KycDetail loginResponse = KycDetail();
    Response response = await authRepo.kycDetails(
        kycDetailsRequest: kycDetailsRequest, loanId: loanId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await authRepo.getLoanSteps(id: loanId, step: "KYC Details");
      loginResponse = KycDetail.fromJson(response.body);
      responseModel = ResponseModel(true, "");
    } else {
      var snackBar = const SnackBar(
          content: Text("Please fill all field correctly"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return loginResponse;
  }

  Future<BniDetail> bankIncomeDetails(
      BankIncomeDetailsRequest bankIncomeDetailsRequest,
      String? loanId,
      BuildContext context) async {
    _isLoading = true;
    BniDetail loginResponse = BniDetail();
    Response response = await authRepo.bankIncomeDetails(
        bankIncomeDetailsRequest: bankIncomeDetailsRequest, loanId: loanId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await authRepo.getLoanSteps(id: loanId, step: "Bank & Income Details");
      loginResponse = BniDetail.fromJson(response.body);
      responseModel = ResponseModel(true, "");
    } else {
      var snackBar = const SnackBar(
          content: Text("Please fill all field correctly"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return loginResponse;
  }

  Future<InsuranceDetail> insuranceDetails(
      InsuranceDetailsRequest insuranceDetailsRequest,
      String? loanId,
      BuildContext context) async {
    _isLoading = true;
    InsuranceDetail loginResponse = InsuranceDetail();
    Response response = await authRepo.insuranceDetails(
        insuranceDetailsRequest: insuranceDetailsRequest, loanId: loanId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await authRepo.getLoanSteps(id: loanId, step: "Insurance Details");
      loginResponse = InsuranceDetail.fromJson(response.body);
      responseModel = ResponseModel(true, "");
    } else {
      var snackBar = SnackBar(
          content: Text("Please fill all field correctly"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      responseModel = ResponseModel(false, "Phone number not valid");
    }
    _isLoading = false;
    update();
    return loginResponse;
  }

  Future<List<NotificationModel>> getNotification() async {
    _isLoading = true;
    Response response = await authRepo.getNotification();
    List<NotificationModel> notificationModel = [];
    if (response.statusCode == 200) {
      response.body["result"].forEach(
          (data) => notificationModel.add(NotificationModel.fromJson(data)));
    }
    _isLoading = false;
    update();
    return notificationModel;
  }

  Future<Response> getMenu(BuildContext context) async {
    _isLoading = true;
    Response response = await authRepo.getMenu();
    if (response.statusCode == 401) {
      authRepo.SetLogin("0");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<ApplyLoanModel> getLoanById() async {
    _isLoading = true;
    ApplyLoanModel applyLoanModel = ApplyLoanModel();
    Response response = await authRepo.getLoanById(authRepo.getUserLoanID());
    if (response.statusCode == 200) {
      applyLoanModel = ApplyLoanModel.fromJson(response.body);
      _appplyloanmodel = applyLoanModel;
    }
    _isLoading = false;
    update();
    return applyLoanModel;
  }

  Future<BankModel> getBankDetails() async {
    _isLoading = true;
    BankModel applyLoanModel = BankModel();
    Response response = await authRepo.getBankDetails();
    if (response.statusCode == 200) {
      applyLoanModel = BankModel.fromJson(response.body);
      _bankModel = applyLoanModel;
    }
    _isLoading = false;
    update();
    return applyLoanModel;
  }

  Future<ApplyLoanModel> getLoan() async {
    _isLoading = true;
    ApplyLoanModel applyLoanModel = ApplyLoanModel();
    Response response = await authRepo.getLoan();
    if (response.statusCode == 200) {
      applyLoanModel = ApplyLoanModel.fromJson(response.body);
      _appplyloanmodel = applyLoanModel;
    }
    _isLoading = false;
    update();
    return applyLoanModel;
  }

  Future<Response> getLoanType(BuildContext context) async {
    _isLoading = true;
    Response response = await authRepo.getLoanType();
    if (response.statusCode == 401) {
      authRepo.SetLogin("0");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<ResponseModel> uploadImage(XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImage(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageAADHARFRONT(
      XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImageAadharFront(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageAADHARBACK(
      XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImageAadharBack(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImagePANFRONT(XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImagePanFront(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImagePayment(XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadCharge(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageSignature(
      XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImageSignature(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageRePayment(XFile images, String emiId) async {
    _isLoading = true;

    ResponseModel responseModel;
    String loanId = getUserLoanId();
    Response response = await authRepo.uploadRePayment(images, loanId, emiId);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageCredit(
      XFile images, String loanID, String creditScore) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response =
        await authRepo.uploadCREDITSCORE(images, loanID, creditScore);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageCreditGET(String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadCREDITSCOREGET(loanID);
    responseModel = ResponseModel(true, "Data is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImagePANBACK(XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImagePanBack(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImagePASSBOOK(XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImagePassBook(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadImageSLIP(XFile images, String loanID) async {
    _isLoading = true;

    ResponseModel responseModel;
    Response response = await authRepo.uploadImageSalarySlip(images, loanID);
    responseModel = ResponseModel(true, "Image is uploading..");

    _isLoading = false;
    update();
    return responseModel;
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    String a = authRepo.getLogin();
    if (a == "0") {
      return false;
    } else {
      return true;
    }
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserID() {
    return authRepo.getUserID();
  }

  String getDeviceID() {
    return authRepo.getDeviceID();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String getUserLoanId() {
    return authRepo.getUserLoanID();
  }

  String getUserLoanStatus() {
    return authRepo.getLoanStatus();
  }

  String getUserLoanCharge() {
    return authRepo.getLoanCharge();
  }

  String getUserLoanType() {
    return authRepo.getUserLoanType();
  }

  String getUserCreditStatus() {
    return authRepo.getCreditStatus();
  }

  String getUserPaymentStatus() {
    return authRepo.getPaymentStatus();
  }

  bool saveUserLoanStatus(String loanStatus) {
    authRepo.saveLoanStatus(loanStatus);
    return true;
  }

  bool saveUserLoanCharge(String loanCharge) {
    authRepo.saveLoanCharge(loanCharge);
    return true;
  }

  bool saveUserLoanType(String loanType) {
    authRepo.saveLoanType(loanType);
    return true;
  }

  bool saveUserCreditStatus(String creditStatus) {
    authRepo.saveCreditStatus(creditStatus);
    return true;
  }

  bool saveUserPaymentStatus(String paymentStatus) {
    authRepo.savePaymentStatus(paymentStatus);
    return true;
  }

  bool saveUserLoanId(String loanId) {
    authRepo.saveUserLoanID(loanId);
    return true;
  }

  bool setFirst() {
    authRepo.setFirst("1");
    return true;
  }

  bool isFirst() {
    String a = authRepo.isfirst();
    if (a == "0") {
      return true;
    } else {
      return false;
    }
  }
}
