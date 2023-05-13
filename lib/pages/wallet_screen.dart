import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hand_signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kreditoption/model/apply_loan_model.dart';
import 'package:kreditoption/pages/bank_details_pay_screen.dart';
import 'package:kreditoption/pages/credit_score_screen.dart';
import 'package:kreditoption/pages/dashboard_other_screen.dart';
import 'package:kreditoption/pages/wallet_confirm_screen.dart';
import 'package:kreditoption/utils/images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timelines/timelines.dart';

import '../controller/auth_controller.dart';
import '../theme/color.dart';
import '../utils/app_constants.dart';
import 'loan_type_screen.dart';

class MyWalletScreen extends StatefulWidget {
  MyWalletScreen ({Key? key}) : super(key: key);

  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}
class _MyWalletScreenState  extends  State<MyWalletScreen > {
  ApplyLoanModel applyLoanModel = ApplyLoanModel();
  bool show = false;
  String paymentStatus = "0",
      paymentAmount = "0",
      creditStatus = "0";
  HandSignatureControl control = new HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  ValueNotifier<String?> svg = ValueNotifier<String?>(null);

  // ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);
  ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);
  String formattedDate = "",
      name = "";

  int step = 3;

  @override
  void initState() {
    super.initState();
    paymentStatus = Get.find<AuthController>().getUserPaymentStatus();
    creditStatus = Get.find<AuthController>().getUserCreditStatus();
    paymentAmount = Get.find<AuthController>().getUserLoanCharge();
    Get.find<AuthController>().getLoanById().then((value) async {
      applyLoanModel = value;
      show = true;
      if (applyLoanModel.status == "Approved") {
        step = 4;
      }
      print(applyLoanModel.id);
      if (applyLoanModel.status == "Disapproved") {
        showAlert(context);
      }
      if (applyLoanModel.personalDetail!.length > 0) {
        try {
          name = applyLoanModel.personalDetail!.elementAt(0).name!;
        } catch (error) {}
      }
      setState(() {});
    });
    /*String loanId= Get.find<AuthController>().getUserLoanId();
    if(loanId.isNotEmpty) {
      Get.find<AuthController>().getLoanById().then((value) async {
        applyLoanModel = value;
        print(applyLoanModel.id);
        if(applyLoanModel.personalDetail!.length>0){
          try {
            name =applyLoanModel.personalDetail!.elementAt(0).name!;
            setState(() {
            });
          }catch(error){
          }
        }
        setState(() {});
      });
    }*/

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            backgroundColor: appBgColor,
            child:
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _buildRowCancel(),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _name = [
      "Loan \nDetails",
      "Basic \nInformation",
      "KYC \nDetails",
      "Conditional \nApproval",
      "Compliance\nOf Conditions",
      "Loan\nDisbursement"
    ];

    //notification
    return WillPopScope(
        onWillPop: () async => false,
        child: Column(children: [
          Container(child:
          Text("My Wallet", style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18,),
            textAlign: TextAlign.left,),
            margin: EdgeInsets.only(left: 20, right: 20),
          ),
          SizedBox(height: 5,),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(color: fillColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child:
            Timeline.tileBuilder(

                theme: TimelineThemeData(
                    direction: Axis.horizontal,
                    connectorTheme: ConnectorThemeData(
                      color: Colors.green,
                      space: 10.0,
                      thickness: 2.0,
                    ),
                    nodePosition: 0,
                    indicatorTheme: IndicatorThemeData(
                        color: Colors.green
                    )
                ),

                builder: TimelineTileBuilder.connectedFromStyle(
                  contentsAlign: ContentsAlign.basic,
                  connectorStyleBuilder: (context, index) {
                    return (index < step)
                        ? ConnectorStyle.solidLine
                        : ConnectorStyle.dashedLine;
                  },
                  indicatorStyleBuilder: (context, index) {
                    return (index < step) ? IndicatorStyle.dot : IndicatorStyle
                        .outlined;
                  },
                  contentsBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(_name.elementAt(index),
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,),
                      ),
                  itemCount: _name.length,
                )
            ),),
          show ? applyLoanModel.status == "Processing" ?
          Container(
            child:
            Row(
                children: [
                  GestureDetector(
                    child: Image.asset(Images.waiting), onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DashBoardOtherScreen()));
                  },),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("LOAN UNDER PROCESSING",
                        style: TextStyle(color: Colors.red, fontSize: 16,),
                        textAlign: TextAlign.left,),
                      SizedBox(height: 5,),
                      Text(
                        "We are checking your application, Please wait till verification",
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 8,),
                        textAlign: TextAlign.left,),
                    ],),
                ]
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 20, right: 20),
          ) : applyLoanModel.status == "Disapproved" ?
          Container(
            child:
            Row(
                children: [
                  GestureDetector(
                    child: Image.asset(Images.waiting), onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DashBoardOtherScreen()));
                  },),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("LOAN UNDER " + applyLoanModel.status.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 16,),
                        textAlign: TextAlign.left,),
                      SizedBox(height: 5,),
                      Text("We are reject your application", maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 8,),
                        textAlign: TextAlign.left,),
                    ],),
                ]
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 20, right: 20),
          ) :
          Container(
            child:
            Row(
                children: [
                  Image.asset(Images.verification),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CONGRATULATION!",
                        style: TextStyle(color: secondary, fontSize: 16,),
                        textAlign: TextAlign.left,),
                      SizedBox(height: 5,),
                      Text(
                        "YOUR LOAN APPLICATION HAS BEEN APPROVED!\n (On Condition)",
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 8,),
                        textAlign: TextAlign.left,),
                    ],),
                ]
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 20, right: 20),
          ) : SizedBox(width: 1,),
          SizedBox(height: 10,),
          show ? applyLoanModel.status == "Processing" ?
          Stack(children: [
            Container(
              height: 270,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  applyLoanModel.personalDetail!.elementAt(0).profile
                      .toString() != null ? Image.network(
                    applyLoanModel.personalDetail!.elementAt(0).profile
                        .toString(), height: 80,) : Image.asset(
                    Images.user, height: 80,),
                  Text(applyLoanModel.personalDetail!.elementAt(0).name!,
                      style: TextStyle(color: Colors.white, fontSize: 18,)),
                  SizedBox(height: 10,),
                  Text("Loan account ID : " + applyLoanModel.id!, maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10,)),
                  SizedBox(height: 10,),
                  Text("Loan Wallet ID : " + applyLoanModel.id!, maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10,)),
                ],),
              padding: EdgeInsets.only(
                  bottom: 50, top: 10, right: 10, left: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(Images.background),
                  fit: BoxFit.cover,
                ),),
            ),
            Container(alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .27,),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("YOUR REQUESTED LOAN AMOUNT :",
                          style: TextStyle(color: Colors.black, fontSize: 12,),
                          textAlign: TextAlign.left,),
                        SizedBox(height: 10,),
                        Text(applyLoanModel.loanAmount!.toString(), maxLines: 5,
                          style: TextStyle(color: secondary, fontSize: 16,),
                          textAlign: TextAlign.left,),
                      ],),
                      padding: EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 0),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.pivot_table_chart_sharp,
                            color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(applyLoanModel.status!, maxLines: 5,
                            style: TextStyle(
                              color: Colors.white, fontSize: 12,),
                            textAlign: TextAlign.left,),
                        ],),
                      decoration: BoxDecoration(color: applyLoanModel.status ==
                          "Processing" ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.only(topRight: Radius
                            .circular(10), bottomRight: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                    )
                  ],),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: fillColor),
              ),)

          ],) : applyLoanModel.status == "Disapproved" ? Stack(children: [
            Container(
              height: 270,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  applyLoanModel.personalDetail!.elementAt(0).profile
                      .toString() != null ? Image.network(
                    applyLoanModel.personalDetail!.elementAt(0).profile
                        .toString(), height: 80,) : Image.asset(
                    Images.user, height: 80,),
                  Text(applyLoanModel.personalDetail!.elementAt(0).name!,
                      style: TextStyle(color: Colors.white, fontSize: 18,)),
                  SizedBox(height: 5,),
                  Text("Loan account ID : " + applyLoanModel.id!, maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10,)),
                  SizedBox(height: 10,),
                  Text("Loan Wallet ID : " + applyLoanModel.id!, maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10,)),
                ],),
              padding: EdgeInsets.only(
                  bottom: 50, top: 10, right: 10, left: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(Images.background),
                  fit: BoxFit.cover,
                ),),
            ),
            Container(alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .27,),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("YOUR REQUESTED LOAN AMOUNT :",
                          style: TextStyle(color: Colors.black, fontSize: 12,),
                          textAlign: TextAlign.left,),
                        SizedBox(height: 10,),
                        Text(applyLoanModel.loanAmount!.toString(), maxLines: 5,
                          style: TextStyle(color: secondary, fontSize: 16,),
                          textAlign: TextAlign.left,),
                      ],),
                      padding: EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 0),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.pivot_table_chart_sharp,
                            color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(applyLoanModel.status!, maxLines: 5,
                            style: TextStyle(
                              color: Colors.white, fontSize: 12,),
                            textAlign: TextAlign.left,),
                        ],),
                      decoration: BoxDecoration(color: applyLoanModel.status ==
                          "Disapproved" ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                    )
                  ],),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: fillColor),
              ),)

          ],) :
          Stack(children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  applyLoanModel.personalDetail!.elementAt(0).profile
                      .toString() != null ? Image.network(
                    applyLoanModel.personalDetail!.elementAt(0).profile
                        .toString(), height: 60,) : Image.asset(
                    Images.user, height: 60,),

                  Text(applyLoanModel.personalDetail!.elementAt(0).name!,
                      style: TextStyle(color: Colors.white, fontSize: 18,)),
                  SizedBox(height: 5,),
                  Text("Loan account ID : " + applyLoanModel.id!, maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10,)),
                  SizedBox(height: 5,),
                  Text("Loan Wallet ID : " + applyLoanModel.id!, maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10,)),
                ],),
              padding: EdgeInsets.only(
                  bottom: 50, top: 10, right: 10, left: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(Images.background),
                  fit: BoxFit.cover,
                ),),
            ),
            Container(alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .20,),
              child: Container(
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("YOUR REQUESTED LOAN AMOUNT",
                          style: TextStyle(color: Colors.black, fontSize: 12,),
                          textAlign: TextAlign.left,),
                        SizedBox(height: 10,),
                        Text(applyLoanModel.loanAmount!.toString(), maxLines: 5,
                          style: TextStyle(color: secondary, fontSize: 16,),
                          textAlign: TextAlign.left,),
                      ],),
                      padding: EdgeInsets.only(
                          top: 10, left: 10, bottom: 10, right: 0),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_outlined, color: Colors.white,),
                          SizedBox(height: 10,),
                          Text("Approved ", maxLines: 5,
                            style: TextStyle(
                              color: Colors.white, fontSize: 12,),
                            textAlign: TextAlign.left,),

                          applyLoanModel.status != "Final Approval" ? Text(
                            "(Conditional Approved)", maxLines: 5,
                            style: TextStyle(color: Colors.white, fontSize: 6,),
                            textAlign: TextAlign.left,) : SizedBox(height: 1,),
                        ],),

                      decoration: BoxDecoration(color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                    )
                  ],),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: fillColor),
              ),),


          ],) : CircularProgressIndicator(),


          show ? applyLoanModel.status == "Approved" ? GestureDetector(
              onTap: () {
                if (paymentStatus == "0") {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return
                        Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          backgroundColor: appBgColor,
                          child:
                          Container(
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                _buildRow(),
                              ],
                            ),
                          ),
                        );
                    },
                  );
               }
                else {
                  var snackBar = SnackBar(
                    content: Text("Payment Already Paid"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Step 1", style: TextStyle(color: Colors.white),),
                    decoration: BoxDecoration(color: secondary,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    padding: EdgeInsets.all(5),),
                  Text("Read the terms & condition carefully",
                    style: TextStyle(color: Colors.grey, fontSize: 12),),
                  Align(
                    alignment: Alignment.topRight,
                    child:  paymentStatus == "1" ?Icon(
                      Icons.check_circle, color: Colors.green,) : Image.asset(
                        Images.expandArrow),)
                ],),
                decoration: BoxDecoration(color: fillColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 5),
              )) : SizedBox(width: 1,) : SizedBox(width: 1,),
          show ? applyLoanModel.status == "Approved" ? paymentStatus == "1" ?
          GestureDetector(onTap: () {
            if (creditStatus == "0") {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  CREDITSCOREScreen(id: applyLoanModel.id.toString(),)));
            } else {
              var snackBar = SnackBar(
                content: Text("Credit Score Already Updated"),
                duration: Duration(seconds: 3),
                backgroundColor: true ? Colors.red : Colors.green,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }, child: Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("Step 2", style: TextStyle(color: Colors.white),),
                decoration: BoxDecoration(color: secondary,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: EdgeInsets.all(5),),
              Text("Enter credit score",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.left,),
              Align(
                alignment: Alignment.topRight,
                child:  creditStatus == "1" ?Icon(
                  Icons.pending, color: Colors.red,) :applyLoanModel.status == "Final Approval"? Icon(
                  Icons.check_circle, color: Colors.green,) : Image.asset(
                    Images.expandArrow),)
            ],),
            decoration: BoxDecoration(color: fillColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
          )) : SizedBox(width: 1,) : SizedBox(width: 1,) : SizedBox(width: 1,),

          //  child: paymentStatus=="1"?Icon(Icons.check_circle,color: Colors.green,):Image.asset(Images.expandArrow),)

          // child:creditStatus=="1"?Icon(Icons.check_circle,color: Colors.green,):Image.asset(Images.expandArrow),)


        ],));
    //end notification
  }

  Widget _buildRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(children: [
        SizedBox(height: 20,),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Terms & Conditions", maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center),
        ), SizedBox(height: 20,),

        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(AppConstants.TERMS,
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,),
        ),
        SizedBox(height: 20,),

        GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    backgroundColor: appBgColor,
                    child:
                    Container(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          _buildRowPay(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child:
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
              decoration: BoxDecoration(color: secondary,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Text("Continue  >>", style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,),
            )
        )
      ],
      ),
    );
  }
  Widget _buildRowAlert(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(children: [
        SizedBox(height: 20,),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("You can apply after "+ date+"", maxLines: 2,
              style: TextStyle(color: Colors.red, fontSize: 18),
              textAlign: TextAlign.center),
        ), SizedBox(height: 20,),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
          child:   Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
            decoration: BoxDecoration(color: secondary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Text("Ok", style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,),
          ),
        )
      ],
      ),
    );
  }
  Widget _buildRowCancel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(children: [
        SizedBox(height: 20,),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Sorry!", maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center),
        ), SizedBox(height: 20,),

        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "WE ARE PRESENTLY UNABLE TO ALLOW YOUR APPLIED LOAN AMOUNT TO TRANSFER YOUR BANK ACCOUNT DUE TO LOW CREDIT SCORE & SOME BAD CREDIT HISTORY/REPORT. YOUR CREDIT SCORE SHOULD HAVE TO BE ABOVE 750 TO BE ALLOWED TO TRANSFER YOUR LOAN AMOUNT." +
                "[ You can re-apply after resolving this issue. No assessment fee will be charged from you for the second time application if your provided documents will be the same .]",
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,),
        ),
        SizedBox(height: 20,),

        GestureDetector(
            onTap: () {
              DateTime fromdate=DateTime.parse(applyLoanModel.createdAt.toString());
              DateTime to=DateTime.now();

              String vd=DateFormat("dd-MM-yyyy").format(fromdate.add(Duration(days: 15, hours: 23)));
              if(daysBetween(fromdate, to)<=15) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return
                      Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        backgroundColor:appBgColor,
                        child:
                        Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              _buildRowAlert(vd),
                            ],
                          ),
                        ),
                      );
                  },
                );
              }else {
                Navigator.push(context, MaterialPageRoute(
                   builder: (context) => LoanTypeScreen()));
              }

            },
            child:
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
              decoration: BoxDecoration(color: secondary,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Text("Re-Apply  >>", style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,),
            )
        )
      ],
      ),
    );
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  Widget _buildRowPay() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(children: [
        SizedBox(height: 20,),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Pay Rs." + paymentAmount, maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center),
        ), SizedBox(height: 20,),

        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(AppConstants.TERMS,
              style: TextStyle(color: Colors.white, fontSize: 10,),
              textAlign: TextAlign.center),
        ),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Date:" + formattedDate,
              style: TextStyle(color: Colors.white, fontSize: 12,),
              textAlign: TextAlign.left),
        ),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Applicant's name: " + name,
              style: TextStyle(color: Colors.white, fontSize: 12,),
              textAlign: TextAlign.left),
        ),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Applicant's signature:",
              style: TextStyle(color: Colors.red, fontSize: 12,),
              textAlign: TextAlign.left),
        ),
        SizedBox(height: 5,),


        Container(height: 150, width: 250, child:
        Center(
          child:
          Stack(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(),
                color: Colors.white,
                child: HandSignature(
                  control: control,
                  type: SignatureDrawType.shape,
                ),
              ),
              CustomPaint(
                painter: DebugSignaturePainterCP(
                  control: control,
                  cp: false,
                  cpStart: false,
                  cpEnd: false,
                ),
              ),
            ],
          ),

        )),
        Container(
          child: Row(
          children: [
            Image.asset(Images.verify),
            SizedBox(width: 3,),
            const Text("Wrong information may lead to rejection of your loan application.",
              style:  TextStyle(color: Colors.white,fontSize: 8),
            ),
          ],),
          margin: EdgeInsets.only(left: 5,top: 10,right: 5),
        ),

        Row(
          children: <Widget>[
            CupertinoButton(
              onPressed: () {
                control.clear();
                svg.value = null;
                // rawImage.value = null;
                rawImageFit.value = null;
              },
              child: Text('clear'),
            ),

          ],
        ),

        SizedBox(height: 10,),
        GestureDetector(
            onTap: () async {
              rawImageFit.value = await control.toImage(
                color: Colors.blueAccent,
                background: Colors.greenAccent,
              );

              var pngBytes =rawImageFit.value;
             // await renderedImage.toByteData(format: ui.ImageByteFormat.png);

              Directory saveDir = await getApplicationDocumentsDirectory();
              String path = '${saveDir.path}/signature.jpg';
              File saveFile = File(path);

              if (!saveFile.existsSync()) {
                saveFile.createSync(recursive: true);
              }
              saveFile.writeAsBytesSync(pngBytes!.buffer.asUint8List(), flush: true);
             // await GallerySaver.saveImage(path, albumName: 'iDream');
              XFile file = new XFile(saveFile.path);
              Get.find<AuthController>().uploadImageSignature(
                  file, applyLoanModel.id.toString()).then((value) {
                Get.find<AuthController>().saveUserPaymentStatus("1");
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    BANKDetailsPayScreen(id: applyLoanModel.id.toString(),)));
              });
            },
            child:
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
              decoration: BoxDecoration(color: secondary,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Text("Continue  >>", style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,),
            )
        )
      ],
      ),
    );
  }
}