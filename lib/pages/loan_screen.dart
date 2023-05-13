import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/model/request/loan_apply_request.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';
import 'package:kreditoption/utils/app_constants.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';

class LoanScreen extends StatefulWidget {
   LoanScreen({this.id,this.roi,this.loanType});
   int? id;
   int? roi;
   String? loanType;
  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {

  String username="";
  String amountinword="";
  bool update=false;
  final TextEditingController _phoneController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _phoneNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  ApplyLoanModel applyLoanModel= ApplyLoanModel();
  @override
  void initState() {
    super.initState();
    principal=valueHolder.toDouble();
    double rate1 = widget.roi! / (12 * 100);
    emiDouble = ((valueHolder.toDouble() * rate1 * pow(1 + rate1, n)) / (pow(1 + rate1, n) - 1));
    emi=emiDouble.round();
    interest = (emiDouble * n) - principal;
    total_amount = principal + interest;
    String loanId= Get.find<AuthController>().getUserLoanId();
    if(loanId.isNotEmpty) {
      Get.find<AuthController>().getLoanById().then((value) async {
        applyLoanModel = value;
        print(applyLoanModel.id);
        if(applyLoanModel.id==null){
          update=false;
        }else{
          update=true;
        }
        setState(() {});
      });
    }
  }
  final List<String> _name=["Loan \nDetails","Basic \nInformation","KYC \nDetails","Loan\nApproval","Confirmation\nCall/SMS","Loan\nDisbursement"];
  bool value = false;

  int valueHolder = 10000;
  int valueTime = 5,emi=0;
 // double rate=8.0;
  double emiDouble=0.0,interest=0.0,total_amount=0.0;
  String selectedValue="";
  List<String> groupValue= ["Personal", "Education","Business", "Care", "Bike","Electronics Gadgets"];
  double principal =0.0;

  double n = 5.0;
   /*one month interest*/ /*one month period*/

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
          Text("Choose Your Loan Amount",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.center,),
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
                  return (index == -1) ? ConnectorStyle.solidLine : ConnectorStyle.dashedLine;
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
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Loan Amount",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
            Text(AppConstants.RUPEE+" "+valueHolder.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
          ],),
        ),
            Slider(
            value: valueHolder.toDouble(),
            min: 10000,
            max: 1000000,
            divisions: 50,
                activeColor: appBgColor,
                inactiveColor: fillColor,
            label: '${valueHolder.round()}',
            onChanged: (double newValue) {
            setState(() {
            valueHolder = newValue.round();
            principal=valueHolder.toDouble();
            n=valueTime.toDouble();
            double rate1 = widget.roi! / (12 * 100);
            emiDouble = ((valueHolder.toDouble() * rate1 * pow(1 + rate1, n)) / (pow(1 + rate1, n) - 1));
            emi=emiDouble.round();
            interest = (emiDouble * n) - principal;
            total_amount = principal + interest;
            });
            },
            semanticFormatterCallback: (double newValue) {
            return '${newValue.round()}';
            }
            ),

        Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Loan Tenure",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
          Text(""+valueTime.toString()+" Months",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
         ],),
        ),
        Slider(
            value: valueTime.toDouble(),
            min: 5,
            max: 100,
            divisions: 100,
            activeColor: appBgColor,
            inactiveColor: fillColor,
            label: '${valueTime.round()}',
            onChanged: (double newValue1) {
              setState(() {
                valueTime = newValue1.round();
                n=valueTime.toDouble();
                double rate1 = widget.roi! / (12 * 100);
                emiDouble = ((valueHolder.toDouble() * rate1 * pow(1 + rate1, n)) / (pow(1 + rate1, n) - 1));
                emi=emiDouble.round();
                interest = (emiDouble * n) - principal;
                total_amount = principal + interest;
              });
            },
            semanticFormatterCallback: (double newValue1) {
              return '${newValue1.round()}';
            }
        ),
        Container(

        width:double.infinity ,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        child:Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Expected EMI :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+emi.toString(), style: TextStyle(color: Colors.black,fontSize: 14),),),
          ],),
          SizedBox(height: 5,),
          const MySeparator(color: Colors.white),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Total payable :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(AppConstants.RUPEE+" "+total_amount.round().toString(), style: TextStyle(color: Colors.black,fontSize: 14),),),
            ],),
          SizedBox(height: 5,),
          const MySeparator(color: Colors.white),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Rate of interest :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(widget.roi!.toString()+"%", style: TextStyle(color: Colors.black,fontSize: 14),),),
            ],),
        ],)
        ),

      /*  Text("Purpose of loan :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),

       GestureDetector(
         onTap: (){
           showDialog(
             context: context,
             builder: (context) {
               return Dialog(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                 elevation: 10,
                 backgroundColor: appBgColor,
                 child: Container(

                   child: ListView(
                     shrinkWrap: true,
                     children: <Widget>[
                       _buildRow( 'Personal'),
                       _buildRow( 'Education'),
                       _buildRow( 'Business'),
                       _buildRow( 'Care'),
                       _buildRow( 'Bike'),
                       _buildRow('Electronics Gadgets'),
                     ],
                   ),
                 ),
               );
             },
           );
         },
        child: Container(child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               Text("Choose a Loan Purpose",style: TextStyle(color: Colors.grey,fontSize: 14),),
               Align(
                 alignment: Alignment. topRight,
                 child: Image.asset(Images.expandArrow),)
             ],),
               decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
               padding: EdgeInsets.all(10),
               margin: EdgeInsets.all(20),
             ),
       ),
*/


        Row( children:  [
          SizedBox(width: 10,),
          Expanded(
              child: IconButton(
                icon: Image.asset(Images.applyNow),
                iconSize: 50,
                onPressed: () {

                  LoanApplyRequest loanapplyrequest= new LoanApplyRequest();
                  loanapplyrequest.loanAmount=valueHolder.toString();
                  loanapplyrequest.loanTenure=valueTime.toString();
                  loanapplyrequest.interest=widget.roi!.toDouble();
                  loanapplyrequest.totalPayment=total_amount.round().toDouble();
                  loanapplyrequest.emi=emi.toDouble();
                  loanapplyrequest.loanTypeId=widget.id.toString();
                 if(!update) {
                   Get.find<AuthController>().loanApply(
                       loanapplyrequest, context).then((value) {
                     if (value.id!.isNotEmpty) {
                       Navigator.push(context, MaterialPageRoute(
                           builder: (context) => ApplyLoanScreen(value)));
                     }
                     else {
                       var snackBar = SnackBar(
                         content: Text("Something went wrong"),
                         duration: Duration(seconds: 3),
                         backgroundColor: true ? Colors.red : Colors.green,);
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                     }
                   });
                 }else{
                   Get.find<AuthController>().loanUpdate(loanapplyrequest,applyLoanModel.id ,context).then((value){
                     if(value.id!.isNotEmpty){
                       Navigator.push(context, MaterialPageRoute(builder: (
                           context) => ApplyLoanScreen(value)));
                     }
                     else{
                       var snackBar = SnackBar(content: Text("Something went wrong"),
                         duration: Duration(seconds: 3),
                         backgroundColor: true ? Colors.red : Colors.green,);
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                     }
                   });
                 }
                },
              )
          ),

          SizedBox(width: 10,),
        ],),
    ]
    ),
    );
  }
  Widget _buildRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text(name,style: TextStyle(color: Colors.white),),
              Spacer(),
              Radio(value: selectedValue,
                 groupValue: groupValue, onChanged: (value){
                 selectedValue=value.toString();
                 setState(() {
               });
             })
            ],
          ),
        ],
      ),
    );
  }
}
