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

class BANKDetailsPayScreen extends StatefulWidget {
  BANKDetailsPayScreen({required this.id});
  String id;

  @override
  _BANKDetailsPayScreenState createState() => _BANKDetailsPayScreenState();
}

class _BANKDetailsPayScreenState extends State<BANKDetailsPayScreen> {
  XFile? imageFile;
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  String username="";
  String amountinword="";
  final TextEditingController _phoneController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _phoneNode=  FocusNode();
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

        Container(
          width:double.infinity ,
          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: secondary,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:load?Text("Pay to "+_bankModel.holderName.toString(),textAlign: TextAlign.center ,style: TextStyle(color: Colors.white),):SizedBox(width: 1,),
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
              Expanded(child: Text("Bank Name", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(load?_bankModel.bankName.toString():"", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
          ],),
          SizedBox(height: 5,),
          const MySeparatorWhite(color: Colors.white,height: 2,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("A/C No", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(load?_bankModel.accountNumber.toString():"", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
          SizedBox(height: 5,),
          const MySeparatorWhite(color: Colors.white,height: 2,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("IFSC Code :", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(load?_bankModel.ifsc.toString():"", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
          SizedBox(height: 5,),
          const MySeparatorWhite(color: Colors.white,height: 2,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("UPI ID", style: TextStyle(color: Colors.black,fontSize: 14),),),
              Expanded(child: Text(load?_bankModel.upi.toString():"", style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.right,),),
            ],),
        ],)
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
                    print(value!.path);
                    imageFile = XFile(value.path);
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
                    Get.find<AuthController>().uploadImagePayment(
                        imageFile!, widget.id).then((value){
                      Get.find<AuthController>().saveUserPaymentStatus("1");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DashBoardScreen()));
                    });

                  }
                  else{
                    var snackBar = SnackBar(content: Text("Image File Required"),
                      duration: Duration(seconds: 3),
                      backgroundColor: true ? Colors.red : Colors.green,);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
