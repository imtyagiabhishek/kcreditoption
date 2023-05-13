import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditoption/pages/dashboard_other_screen.dart';
import 'package:kreditoption/pages/wallet_confirm_screen.dart';
import 'package:kreditoption/utils/images.dart';
import 'package:kreditoption/widgets/emi_item.dart';
import 'package:timelines/timelines.dart';

import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../theme/color.dart';
import '../utils/dimensions.dart';
import '../widgets/my_separator_white.dart';
import 'dashboard_screen.dart';

class EMIStatusScreen extends StatefulWidget {
  EMIStatusScreen ({Key? key}) : super(key: key);

  @override
  _EMIStatusScreen createState() => _EMIStatusScreen();
}

class _EMIStatusScreen extends State<EMIStatusScreen> {
  XFile? imageFile;
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  bool credit=false,net=false,upi=false,bank=false;
  ApplyLoanModel applyLoanModel=ApplyLoanModel();
  bool show=false;
  String emiId="";
  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getLoanById().then((value) async {
      applyLoanModel = value;
      show=true;
      applyLoanModel.emis!.sort((a,b)=> a.dueDate!.compareTo(b.dueDate!));
      for(int i=0;i<applyLoanModel.emis!.length;i++){
        if(applyLoanModel.emis!.elementAt(i).remark=="Due"){
          emiId=applyLoanModel.emis!.elementAt(i).id!;
          break;
        }
      }
      print(applyLoanModel.id);
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {

    final List<String> _name=["Loan \nDetails","Basic \nInformation","KYC \nDetails","Loan\nApproval","Confirmation\nCall/SMS","Loan\nDisbursement"];

    //notification
  return Container(child: SingleChildScrollView(physics: ScrollPhysics(),
        child: Column(  children: [
         Container(child:
         Text("EMI Status",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
          margin: EdgeInsets.only(left: 20,right: 20),
         ),

        Container(

          width:double.infinity ,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
          child:Column(children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
              decoration: BoxDecoration(color: secondary ,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("months", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,

                Text("payments", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,

                Text("Remarks", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,
              ],),

            ),

           show? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10),
              child:applyLoanModel.emis!.isNotEmpty? ListView.builder(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                itemCount: applyLoanModel.emis!.length,
                shrinkWrap:true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return EMIItem(
                    data:  applyLoanModel.emis!.elementAt(index),
                    onTap: () {
                    },
                  );
                },
              ):Center(child:const Text("No Data Available", style: TextStyle(color: appBgColor),) ,),
            ):CircularProgressIndicator(),



          ],)
      ),
        Text("Choose  re-Payment Method:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),


        Container(child:CheckboxListTile(
        onChanged: (value){
          if(bank){
            credit=false;
            net=false;
            upi=false;
            bank=false;
          }else{
            bank=true;
            net=false;
            upi=false;
            credit=false;
          }
          setState(() {

          });
        },
        activeColor:appBgColor,
        dense: true,
        //font change
        title: new Text(
          "Bank Transfer",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        value: bank,
        secondary: Container(
          height: 20,
          width: 20,
          child: Image.asset(
            Images.bank,
            fit: BoxFit.cover,
          ),
        ),
      ),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,left: 20,right: 20),
      ),
      Container(child:CheckboxListTile(
        onChanged: (value){

          if(credit){
            credit=false;
            net=false;
            upi=false;
            bank=false;
          }else{
            credit=true;
            net=false;
            upi=false;
            bank=false;
          }
          setState(() {

          });
        },
        activeColor:appBgColor,
        dense: true,
        //font change
        title: new Text(
          "Credit or Debit",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        value: credit,
        secondary: Container(
          height: 20,
          width: 20,
          child: Image.asset(
            Images.credit_card,
            fit: BoxFit.cover,
          ),
        ),
      ),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,left: 20,right: 20),
      ),
      Container(child:CheckboxListTile(
        onChanged: (value){
          if(upi){
            credit=false;
            net=false;
            upi=false;
            bank=false;
          }else{
            credit=false;
            net=false;
            upi=true;
            bank=false;
          }
          setState(() {

          });
        },
        activeColor:appBgColor,
        dense: true,
        //font change
        title: new Text(
          "UPI Banking",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        value: upi,
        secondary: Container(
          height: 30,
          width: 30,
          child: Image.asset(
            Images.upi,
            fit: BoxFit.cover,
          ),
        ),
       ),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,left: 20,right: 20),
      ),
       Container(child:CheckboxListTile(
        onChanged: (value){
          if(net){
            credit=false;
            net=false;
            upi=false;
            bank=false;
          }else{
            credit=false;
            net=true;
            upi=false;
            bank=false;
          }
          setState(() {

          });
        },
        activeColor:appBgColor,
        dense: true,
        //font change
        title: new Text(
          "NET Banking",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        value: net,
        secondary: Container(
          height: 20,
          width: 20,
          child: Image.asset(
            Images.net,
            fit: BoxFit.cover,
          ),
        ),
      ),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,left: 20,right: 20),
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<PickedFile?>(
            future: pickedFile,
            builder: (context, snap) {
              if (snap.hasData) {
                return Align(
                    alignment: Alignment.center,
                    child:
                    Container(child:Image.file(
                      File(snap.data!.path),
                      fit: BoxFit.contain,),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 5,left: 10,right: 10),

                    )
                );
              }
              return SizedBox(height: 1,);
            },
          ),

          GestureDetector( child:
          Container(child: Image.asset(Images.payment),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 5,left: 10,right: 10),),
            onTap: () async{
              pickedFile = picker
                  .getImage(
                source: ImageSource.gallery,
              )
                  .whenComplete(() {
                pickedFile.then((value) {
                  imageFile = XFile(value!.path);
                  //  Get.find<AuthController>().uploadImagePANBACK(imageFilePANBack!,widget.applyLoanModel.id!);
                }
                );
                setState(() {});
              });
            },)
        ],
      ),


        Row( children:  [
        SizedBox(width: 10,),
        Expanded(
            child: IconButton(
              icon: Image.asset(Images.submit),
              iconSize: 50,
              onPressed: () {
                if(imageFile!=null) {
                  if(emiId!="") {
                    Get.find<AuthController>().uploadImageRePayment(
                        imageFile!, emiId).then((value) {
                      var snackBar = const SnackBar(content: Text("EMI Paid Successfully"),
                        duration: Duration(seconds: 3),
                        backgroundColor: false ? Colors.red : Colors.green,);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DashBoardScreen()));
                    });
                  }else{
                    var snackBar = SnackBar(content: Text("Payment Already done"),
                      duration: Duration(seconds: 3),
                      backgroundColor: true ? Colors.red : Colors.green,);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
                else{
                  var snackBar = SnackBar(content: Text("Image File Required"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                /*Navigator.push(context, MaterialPageRoute(builder: (
                    context) => DashBoardScreen()));*/
              },
            )
        ),

        SizedBox(width: 10,),
      ],),

    ],)));

    //end notification
  }
}