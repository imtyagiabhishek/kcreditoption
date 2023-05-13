import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:kreditoption/utils/app_constants.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../model/apply_loan_model_response.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';
import 'dashboard_screen.dart';

class LoanDetailsScreen extends StatefulWidget {
  LoanDetailsScreen(this.applyLoanModel);
  final ApplyLoanResponse applyLoanModel;
  @override
  _LoanDetailsScreenState createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {

  String username="";
  String amountinword="";
  final TextEditingController _phoneController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _phoneNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  ApplyLoanModel applyLoanModel= ApplyLoanModel();
  bool show=false;
  @override
  void initState() {
    super.initState();
    String loanId= Get.find<AuthController>().getUserLoanId();
    if(loanId.isNotEmpty) {
      Get.find<AuthController>().getLoanById().then((value) async {
        applyLoanModel = value;
        print(applyLoanModel.id);
        if(applyLoanModel.id==null){
          show=false;
        }else{
          show=true;
        }
        setState(() {});
      });
    }
  }
  bool value = false;

  String selectedValue="";
  String _selectedDate="";
  List<String> groupValue= ["Male","Female","Other"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child: Column(children: <Widget>[
         Container(
           decoration: const BoxDecoration(
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
        Column(children: const <Widget>[
          Text("Confirm Loan Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
          ]),

        const SizedBox(height: 10,),
          Container(child:Row(children: const <Widget>[
            Icon(Icons.auto_graph_outlined,color: secondary,),
            SizedBox(width: 5,),
            Text("Loan Details",style: TextStyle(color: secondary,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.right,),
          ]),
            margin: EdgeInsets.only(top: 5,left: 20,right: 10),
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Tenure :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+applyLoanModel.loanTenure!.toString()+" Months":"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Expected EMI :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+AppConstants.RUPEE+" "+widget.applyLoanModel.emi!.toString():"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Rate of interest :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+applyLoanModel.interest!.toString()+" %":"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Total payable :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+AppConstants.RUPEE+" "+applyLoanModel.totalPayment!.toString():"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),

          Container(child:Row(children: const <Widget>[
            Icon(Icons.edit_note,color: secondary,),
            SizedBox(width: 5,),
            Text("Other Details",style: TextStyle(color: secondary,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.right,),
          ]),
            margin: EdgeInsets.only(top: 5,left: 20,right: 10),
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Insurance amount :", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+AppConstants.RUPEE+" "+applyLoanModel.insuranceDetail!.elementAt(0).amount!.toString():"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Aadhaar Card No.", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+applyLoanModel.kycDetail!.elementAt(0).aadharNumber!.toString():"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Pan Card No.", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?""+applyLoanModel.kycDetail!.elementAt(0).panNumber!.toString():"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),
          Container(
              width:double.infinity ,
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Bank A/C No.", style: TextStyle(color: Colors.black,fontSize: 14),),),
                    Align(
                      alignment: Alignment. topRight,
                      child: Text(show?applyLoanModel.bniDetail!.elementAt(0).accountNumber!.toString():"", style: TextStyle(color: secondary,fontSize: 14),),),
                  ],),
                const SizedBox(height: 5,),
              ],)
          ),

        Container(child: Row(
          children: [
             Image.asset(Images.verify),
             Text("Wrong information may lead to rejection of your loan application.",
                style:  const TextStyle(color: Colors.grey,fontSize: 10),
            ),
          ],),
          margin: EdgeInsets.only(top:5,left: 20,right: 10),
        ),
        Row( children:  [
          SizedBox(width: 10,),
          Expanded(
              child: IconButton(
                icon: Image.asset(Images.agree),
                iconSize: 50,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                },
              )
          ),

          SizedBox(width: 10,),
        ],),
    ]
    ),
      )
    );
  }
  Widget _buildRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child:   Column(children: [
        SizedBox(height: 20,),
      Container(padding: const EdgeInsets.symmetric(horizontal: 20.0),child: Text("You have successfully completed the loan application",maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center),
      ),SizedBox(height: 20,),
        Image.asset(Images.calculator,height: 60,width: 120,),
        SizedBox(height: 20,),
      Container(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: Text("NOW SIT BACK AND RELAX.\nOUR TEAM WILL REVERT YOU SHORTLY.",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),
       ),
        SizedBox(height: 20,),

        GestureDetector(
          onTap: (){
           Get.find<AuthController>().saveUserLoanStatus("1");
            Navigator.push(context, MaterialPageRoute(builder: (
                context) => DashBoardScreen()));
          },
          child:
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 15),
          decoration: BoxDecoration(color: secondary ,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
          ),
          child: Text("Continue  >>", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,
        )
        )
      ],
      ),
    );
  }
}
