import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';
import 'package:kreditoption/pages/dashboard_screen.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:kreditoption/utils/app_constants.dart';
import 'package:screenshot/screenshot.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';
import '../widgets/my_separator_white.dart';

class LoanEMIReportScreen extends StatefulWidget {
  LoanEMIReportScreen({required this.rate,required this.time,required this.downPayment,required this.princpal});
  double princpal;
  double downPayment;
  double time;
  double rate;
  @override
  _LoanEMIReportScreenState createState() => _LoanEMIReportScreenState();
}

class _LoanEMIReportScreenState extends State<LoanEMIReportScreen> {

  int _counter = 0;
  ScreenshotController screenshotController = ScreenshotController();


  String username="";
  String amountinword="";
  final TextEditingController _phoneController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _phoneNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  double emiDouble=0.0,interest=0.0,rate=0.0,principal=0.0;
  int emi=0; double time=0.0,timemonth=0.0;
  double totalAmount=0.0,totalInterst=0.0,totalPrincipal=0.0;
  @override
  void initState() {
    super.initState();

    time=widget.time*12;
    timemonth=widget.time*12.0;
    totalPrincipal=widget.princpal-widget.downPayment;
    principal=totalPrincipal;
    double rate1 = widget.rate / (12 * 100);
    print(rate1);
    emiDouble = ((principal * rate1 * pow(1 + rate1, widget.time*12)) / (pow(1 + rate1, widget.time*12) - 1));
    emi=emiDouble.round();
    interest = (emiDouble * widget.time*12) - principal;
    totalAmount = totalPrincipal + interest;
    totalInterst=interest;
        setState(() {});
    }
  final List<String> _name=["Loan \nDetails","Basic \nInformation","KYC \nDetails","Loan\nApproval","Confirmation\nCall/SMS","Loan\nDisbursement"];
  bool value = false;

  int valueHolder = 1000;
  int valueTime = 5;
  String selectedValue="";
  List<String> groupValue= ["Personal", "Education","Business", "Care", "Bike","Electronics Gadgets"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:
        Screenshot(
        controller: screenshotController,
         child:
         Column(children: <Widget>[
         Container(
           decoration: BoxDecoration(
             color: appBgColor,
             borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(230,50),bottomRight:Radius.elliptical(230,50)),
           ),
           child:Column(children: [
           Center(child: Column(children: <Widget>[
             Container(
                 margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                 child:Image.asset(Images.logo,height: 100,width: 100,)),
           ])),
         ],),),
         const SizedBox(height: 20,),
         Container(child:
          Text("Loan EMI Report",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
        margin: EdgeInsets.only(left: 20,right: 20),
        ),
         Text("Your loan report :",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),),

         Container(
          width:double.infinity ,
          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: secondary,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:Text(emi.toString()+" EMI/MONTH ",textAlign: TextAlign.center ,style: TextStyle(color: Colors.white),),
          ),
         Container(
          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Principle Amount:", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+widget.princpal.toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
        ),
         Container(
          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Interest Payble:", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+totalInterst.round().toInt().toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),

            ],),
        ),
         Container(
          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Total Payble:", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+totalAmount.round().toInt().toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
        ),
         Container(
          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Taxes", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text("00.00", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
        ),
         Container(

        width:double.infinity ,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        child:Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text("Total Amount :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+widget.princpal.toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
          ],),
          SizedBox(height: 5,),
          const MySeparatorWhite(color: Colors.white,height: 2,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Down Payment:", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+widget.downPayment.toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
          SizedBox(height: 5,),
          const MySeparatorWhite(color: Colors.white,height: 2,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Tenure :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(timemonth.toInt().toString()+" Months", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
          SizedBox(height: 5,),
          const MySeparatorWhite(color: Colors.white,height: 2,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Interest Rate :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(widget.rate.toString()+"%", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
        ],)
        ),

         Row( children:  [
          SizedBox(width: 10,),
          Expanded(
              child: IconButton(
                icon: Image.asset(Images.downloadReport),
                iconSize: 50,
                onPressed: () {
                  var container=Container(child:
                  Column(children: <Widget>[
                  Container(
                  decoration: BoxDecoration(
                    color: appBgColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(230,50),bottomRight:Radius.elliptical(230,50)),
                  ),
                    child:Column(children: [
                      Center(child: Column(children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                            child:Image.asset(Images.logo,height: 100,width: 100,)),
                      ])),
                    ],),),
                  const SizedBox(height: 20,),
                  Container(child:
                  Text("Loan EMI Report",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  ),
                  Text("Your loan report :",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),),

                  Container(
                  width:double.infinity ,
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: secondary,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:Text(emi.toString()+" EMI/MONTH ",textAlign: TextAlign.center ,style: TextStyle(color: Colors.white),),
                  ),
                  Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Principle Amount:", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(AppConstants.RUPEE+" "+widget.princpal.toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  ),
                  Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Interest Payble:", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(AppConstants.RUPEE+" "+totalInterst.round().toInt().toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),

                  ],),
                  ),
                  Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Total Payble:", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(AppConstants.RUPEE+" "+totalAmount.round().toInt().toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  ),
                  Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: third,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Taxes", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text("00.00", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  ),
                  Container(

                  width:double.infinity ,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:Column(children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Expanded(child: Text("Total Amount :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(AppConstants.RUPEE+" "+widget.princpal.toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  SizedBox(height: 5,),
                  const MySeparatorWhite(color: Colors.white,height: 2,),
                  SizedBox(height: 5,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Down Payment:", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(AppConstants.RUPEE+" "+widget.downPayment.toString(), style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  SizedBox(height: 5,),
                  const MySeparatorWhite(color: Colors.white,height: 2,),
                  SizedBox(height: 5,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Tenure :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(timemonth.toInt().toString()+" Months", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  SizedBox(height: 5,),
                  const MySeparatorWhite(color: Colors.white,height: 2,),
                  SizedBox(height: 5,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Text("Interest Rate :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                  Expanded(child: Text(widget.rate.toString()+"%", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
                  ],),
                  ],)
                  )])
                  );
                  screenshotController
                      .captureFromWidget(
                      InheritedTheme.captureAll(
                          context, Material(child: container)),
                      delay: Duration(seconds: 1))
                      .then((capturedImage) {

                    // showing the captured invisible widgets
                   // ShowCapturedWidget(context, capturedImage);
                    _saved(capturedImage);
                  });
                },
              )
          ),

          SizedBox(width: 10,),
        ],),
    ]
    ),)
    );
  }
  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
  _saved(image) async {
    final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
    var snackBar = SnackBar(content: Text("File Saved to Gallery"),
      duration: Duration(seconds: 3),
      backgroundColor:Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
