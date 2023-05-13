import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/model/apply_loan_model.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:kreditoption/pages/personal_details_screen.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model_response.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';

class ApplyLoanScreen extends StatefulWidget {
  ApplyLoanScreen( this.applyLoanModel);
  final ApplyLoanResponse applyLoanModel;
  @override
  _ApplyLoanScreenState createState() => _ApplyLoanScreenState();
}

class _ApplyLoanScreenState extends State<ApplyLoanScreen> {

  String username="";
  String amountinword="";
  final TextEditingController _phoneController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _phoneNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  ApplyLoanModel applyLoanModel= ApplyLoanModel();
  String loanType="";
  @override
  void initState() {
    super.initState();
    loanType= Get.find<AuthController>().getUserLoanType();
   String loanId= Get.find<AuthController>().getUserLoanId();
   if(loanId.isNotEmpty) {
     Get.find<AuthController>().getLoanById().then((value) async {
       applyLoanModel = value;
       setState(() {});
     });
   }
  }
  final List<String> _name=["Loan \nDetails","Basic \nInformation","KYC \nDetails","Loan\nApproval","Confirmation\nCall/SMS","Loan\nDisbursement"];
  bool value = false;

  int valueHolder = 1000;
  int valueTime = 5;
  final List<String> _title=["Personal Details","KYC Details","Bank Details","Income Details","Insurance Details"];
  final List<String> _description=["Fill up the application from having all the details.",
  "Please upload your KYC documents.",
    "Please upload your bank details.","Submit your income details accurately.",
    "Upload your basic details of the insurance policy."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:

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
        Center(child: Column(children: <Widget>[
          Text("Apply For "+loanType,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.center,),
        ])),
        Container(
          width:double.infinity ,
          height: 60,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  return (index == 0) ? ConnectorStyle.solidLine : ConnectorStyle.dashedLine;
                },
                indicatorStyleBuilder:(context,index){
                  return (index == 0) ?IndicatorStyle.dot:IndicatorStyle.outlined;
                } ,
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(_name.elementAt(index),style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                ),
                itemCount: _name.length,
              )
          ),),
        Container(
            width:double.infinity ,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
             child:Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Expanded(child: Text("Loan Amount Selected :",maxLines: 1, style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,child: Text(widget.applyLoanModel.loanAmount!.toString(), style: TextStyle(color: appBgColor,fontSize: 14),),),
                ],),
               const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Tenure :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                    child: Text(widget.applyLoanModel.loanTenure.toString()+" Months", style: TextStyle(color: appBgColor,fontSize: 14),),),
                  ],),
               const SizedBox(height: 5,),

           ],)
           ),
        Container(
            width: double.infinity,
            child: Align(
              alignment: Alignment. topLeft,
              child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                connectorTheme: ConnectorThemeData(
                  color: Colors.grey,
                  space: 40.0,
                  thickness: 2.0,
                ),
                indicatorPosition: 0,
                indicatorTheme: IndicatorThemeData(
                    color: Colors.grey
                )
            ),

               builder: TimelineTileBuilder.connectedFromStyle(
               contentsAlign: ContentsAlign.reverse,
               oppositeContentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [

                Align(
                alignment: Alignment. topLeft,
                child: Text(_title.elementAt(index),textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                ),
                Align(alignment: Alignment. topLeft,
                  child: Text(_description.elementAt(index),textAlign: TextAlign.left,style: TextStyle(fontSize: 10,color: Colors.grey))
                    ),
              ],),
            ),
               contentsBuilder: (context, index) => Card(
               color: secondary,
               child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                child: Text('Step $index',style: TextStyle(color: Colors.white),),
              ),
            ),

            connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
            indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
            itemCount: 5,
            ),
          )
         ),
        ),
        SizedBox(height: 20,),
        Row( children:  [
          SizedBox(width: 10,),
          Expanded(
              child: IconButton(
                icon: Image.asset(Images.continueImage),
                iconSize: 50,
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (
                      context) => PersonalDetailsScreen(widget.applyLoanModel)));
                },
              )
          ),

          SizedBox(width: 10,),
        ],),
    ]
    ),
    );
  }
}
