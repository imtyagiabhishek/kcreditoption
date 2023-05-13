import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';
import 'package:kreditoption/pages/dashboard_screen.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:kreditoption/utils/app_constants.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/bank_model.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';
import '../widgets/my_separator_white.dart';

class CREDITSCOREScreen extends StatefulWidget {
  CREDITSCOREScreen({required this.id});
  String id;

  @override
  _CREDITSCOREScreenState createState() => _CREDITSCOREScreenState();
}

class _CREDITSCOREScreenState extends State<CREDITSCOREScreen> {
  XFile? imageFile;
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  String username="";
  String amountinword="";
  String status = "true";
  final TextEditingController _scoreController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _scoreNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  bool load=false;
  BankModel _bankModel=BankModel();
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().getBankDetails().then((value)  async {
      _bankModel=value;
      load=true;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:

          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: <Widget>[

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
              Text("My Wallet",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
                margin: EdgeInsets.only(left: 20,right: 20),
              ),
              const SizedBox(height: 20,),
              Center(child: Column(children: <Widget>[
                Text("Please Enter The Latest Credit Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.center,),
              ])),


              SizedBox(height: 10,),
              Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                        controller: _scoreController,
                        focusNode: _scoreNode,
                        style:  TextStyle(color: Colors.black,fontSize: 14),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: "Credit Score",
                          filled: true,
                          fillColor: fillColor,
                          labelStyle: TextStyle(color: fillColor,fontSize: 14),
                          contentPadding: EdgeInsets.all(10),
                        )
                    ),
                  ),
                ],),
                decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
              ),

              const SizedBox(height: 20,),
              Center(child: Column(children: <Widget>[
                Text("Upload Credit Report",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.center,),
              ])),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RadioListTile(
                    title: Text("you may upload the credit report downloaded, from any valid platform.",style: TextStyle(fontSize: 10),),
                    value: "true",
                    groupValue: status,
                    onChanged: (value){
                      setState(() {
                        status = "true";
                      });
                    },
                  ),
                  SizedBox(height: 5,),
                  Text("or",style: TextStyle(fontSize: 10),),
                  SizedBox(height: 5,),
                  RadioListTile(
                    title: Text("Authorized us to check your credit report from our end.",style: TextStyle(fontSize: 10),),
                    value: "false",
                    groupValue: status,
                    onChanged: (value){
                      setState(() {
                        status = "false";
                      });
                    },
                  ),

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
                Container(child: Image.asset(Images.credit),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 5,left: 10,right: 10),),
                  onTap: () async{
                  pickedFile = picker
                    .getImage(
                   source: ImageSource.gallery,
                   )
                    .whenComplete(() {
                  pickedFile.then((value) {
                    print(value!.path);
                    imageFile = XFile(value.path);
                  //  Get.find<AuthController>().uploadImagePANBACK(imageFilePANBack!,widget.applyLoanModel.id!);
                  }
                  );
                  setState(() {});
                });
              },)],),
               Row( children:  [
               SizedBox(width: 10,),
               Expanded(
                child: IconButton(
                icon: Image.asset(Images.submit),
                iconSize: 50,
                onPressed: () {
                  if(status=="true") {
                    if (_scoreController.text.isEmpty) {
                      var snackBar = SnackBar(content: Text(
                          "Credit Score Required"),
                        duration: Duration(seconds: 3),
                        backgroundColor: true ? Colors.red : Colors.green,);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else if (imageFile == null) {
                      var snackBar = SnackBar(
                        content: Text("Image File Required"),
                        duration: Duration(seconds: 3),
                        backgroundColor: true ? Colors.red : Colors.green,);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else {
                      Get.find<AuthController>().uploadImageCredit(
                          imageFile!, widget.id,
                          _scoreController.text.toString()).then((value) {
                        Get.find<AuthController>().saveUserCreditStatus("1");
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DashBoardScreen()));
                      });
                    }
                  }else{
                  Get.find<AuthController>().uploadImageCreditGET(
                   widget.id).then((value) {
                  Get.find<AuthController>().saveUserCreditStatus("1");
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DashBoardScreen()));
                  });

                  }
                },
              )
              ),

              SizedBox(width: 10,),
        ],),

    ]
    )),
    );
  }

}
