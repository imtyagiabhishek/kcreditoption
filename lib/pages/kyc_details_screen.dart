import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditoption/model/request/kyc_details_request.dart';
import 'package:kreditoption/pages/bank_details_screen.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../model/apply_loan_model_response.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class KYCDetailsScreen extends StatefulWidget {
  KYCDetailsScreen(this.applyLoanModel);
  final ApplyLoanResponse applyLoanModel;
  @override
  _KYCDetailsScreenState createState() => _KYCDetailsScreenState();
}

class _KYCDetailsScreenState extends State<KYCDetailsScreen> {

  final picker = ImagePicker();
  bool value = false;
  XFile? imagefileFront,imageFileBack,imagefilePANFront,imageFilePANBack;
  late Future<PickedFile?> pickedFileFront = Future.value(null);
  late Future<PickedFile?> pickedFileBack = Future.value(null);
  late Future<PickedFile?> pickedFilePANFront = Future.value(null);
  late Future<PickedFile?> pickedFilePANBack = Future.value(null);
  String username="";
  String amountinword="";
  final TextEditingController _aadharController=  TextEditingController();
  final TextEditingController _panController=  TextEditingController();
  final  FocusNode _aadharNode=  FocusNode();
  final  FocusNode _panNode=  FocusNode();
  String imageAadharBack="",imageAadharFront="",imagePANBack="",imagePANFront="";
  @override
  void initState() {
    super.initState();
    ApplyLoanModel _applyloanmodel= Get.find<AuthController>().appplyloanmodel;
    if(_applyloanmodel.kycDetail!.length>0){
      try {
        _aadharController.text =_applyloanmodel.kycDetail!.elementAt(0).aadharNumber!;
        _panController.text =_applyloanmodel.kycDetail!.elementAt(0).panNumber!;
        imagePANFront=_applyloanmodel.kycDetail!.elementAt(0).panFront!;
        imagePANBack=_applyloanmodel.kycDetail!.elementAt(0).panBack!;
        imageAadharBack=_applyloanmodel.kycDetail!.elementAt(0).aadharBack!;
        imageAadharFront=_applyloanmodel.kycDetail!.elementAt(0).aadharFront!;
      }catch(error){}
    }
  }

  String selectedValue="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body:
        SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Column(children: <Widget>[
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
          Text("KYC Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
          Text("Please upload the following documents",style: TextStyle(color: Colors.grey, fontSize: 14,),textAlign: TextAlign.left,),
        ]),

        const SizedBox(height: 10,),
        Column(children: const <Widget>[

          Text("Aadhar Card",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.right,),
          Text("This will be used to verify your address",style: TextStyle(color: Colors.grey, fontSize: 10,),textAlign: TextAlign.left,),
        ]),

        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(Images.aadhar),),
            const SizedBox(width: 10,),
            Flexible(
              child: TextField(
                controller: _aadharController,
                   focusNode: _aadharNode,
                   keyboardType: TextInputType.number,
                  style:  const TextStyle(color: Colors.grey,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Aadhar Card number",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<PickedFile?>(
                future: pickedFileFront,
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
                  return const SizedBox(height: 1,);
                },
              ),

              GestureDetector( child:
              Container(child: Image.asset(Images.aadhar_front),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 5,left: 20,right: 20),),
                onTap: () async{
                  pickedFileFront = picker
                      .getImage(
                    source: ImageSource.gallery,
                  )
                      .whenComplete(() {
                    pickedFileFront.then((value) {
                      print(value!.path);
                      imagefileFront = XFile(value.path);
                      imageAadharFront=imagefileFront!.path;
                      print(imagefileFront!.path);
                      Get.find<AuthController>().uploadImageAADHARFRONT(imagefileFront!,widget.applyLoanModel.id!);
                    }
                    );
                    setState(() {});
                  });
                },)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<PickedFile?>(
                future: pickedFileBack,
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
              Container(child: Image.asset(Images.aadhar_back),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 5,left: 20,right: 20),),
                onTap: () async{
                  pickedFileBack = picker
                      .getImage(
                    source: ImageSource.gallery,
                  ).whenComplete(() {
                    pickedFileBack.then((value) {
                      print(value!.path);
                      imageFileBack = XFile(value.path);
                      imageAadharBack=imageFileBack!.path;
                      print(imageFileBack!.path);
                      Get.find<AuthController>().uploadImageAADHARBACK(imageFileBack!,widget.applyLoanModel.id!);
                    }
                    );
                    setState(() {});
                  });
                },)


            ],
          ),
        /*Container(child: Image.asset(Images.aadhar_front),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),),
        Container(child: Image.asset(Images.aadhar_back),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),),
*/
        const SizedBox(height: 10,),
        Column(children: const <Widget>[

          Text("PAN Card",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.right,),
          Text("This will be used to verify your address",style: TextStyle(color: Colors.grey, fontSize: 10,),textAlign: TextAlign.left,),
        ]),

        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(Images.pan),),
            SizedBox(width: 10,),
            Flexible(
              child: TextField(
                controller: _panController,
                  focusNode: _panNode,
                  keyboardType: TextInputType.text,
                  style:  const TextStyle(color: Colors.grey,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "PAN Card number",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<PickedFile?>(
                future: pickedFilePANFront,
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
                  return const SizedBox(height: 1,);
                },
              ),

              GestureDetector( child:
              Container(child: Image.asset(Images.pan_front),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 5,left: 10,right: 10),),
                onTap: () async{
                  pickedFilePANFront = picker
                      .getImage(
                    source: ImageSource.gallery,
                  )
                      .whenComplete(() {
                    pickedFilePANFront.then((value) {
                      print(value!.path);
                      imagefilePANFront = XFile(value.path);
                      imagePANFront=imagefilePANFront!.path;
                      print(imagefilePANFront!.path);
                      Get.find<AuthController>().uploadImagePANFRONT(imagefilePANFront!,widget.applyLoanModel.id!);
                    }
                    );
                    setState(() {});
                  });
                },)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<PickedFile?>(
                future: pickedFilePANBack,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return Align(
                        alignment: Alignment.center,
                        child:
                        Container(child:Image.file(
                          File(snap.data!.path),
                          fit: BoxFit.contain,),
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 5,left: 10,right: 10),

                        )
                    );
                  }
                  return SizedBox(height: 1,);
                },
              ),

              GestureDetector( child:
              Container(child: Image.asset(Images.pan_back),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 5,left: 10,right: 10),),
                onTap: () async{
                      pickedFilePANBack = picker
                          .getImage(
                        source: ImageSource.gallery,
                      )
                      .whenComplete(() {
                      pickedFilePANBack.then((value) {
                      print(value!.path);
                      imageFilePANBack = XFile(value.path);
                      imagePANBack=imageFilePANBack!.path;
                      Get.find<AuthController>().uploadImagePANBACK(imageFilePANBack!,widget.applyLoanModel.id!);
                    }
                    );
                    setState(() {});
                  });
                },)
            ],
          ),

        Container(child: Row(
          children: [
             Image.asset(Images.verify),
             const Text("Wrong information may lead to rejection of your loan application.",
                style:  TextStyle(color: Colors.grey,fontSize: 10),
            ),
          ],),
          margin: EdgeInsets.only(left: 20,right: 10),
        ),
        Row( children:  [
          const SizedBox(width: 10,),
          Expanded(
              child: IconButton(
                icon: Image.asset(Images.continueImage),
                iconSize: 50,
                onPressed: () {
                  if(_aadharController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Aadhar Number required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(_aadharController.text.length!=12){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Aadhar Number Not Valid", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_panController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("PAN No required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(imagePANBack==""){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("PAN Card Back Picture required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(imagePANFront==""){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("PAN Card Front Picture required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(imageAadharFront==""){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Aadhar Card Front Picture required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(imageAadharBack==""){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Aadhar Card Back Picture required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else{
                    KYCDetailsRequest personalDetails= KYCDetailsRequest();
                    personalDetails.aadharNumber=_aadharController.text.toString();
                    personalDetails.panNumber=_panController.text.toString();
                    Get.find<AuthController>().kycDetails(personalDetails,widget.applyLoanModel.id ,context).then((value){
                      if(value.id!.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BankDetailsScreen(widget.applyLoanModel)));
                      }
                      else{
                        var snackBar = const SnackBar(content: Text("Please fill all field correctly"),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }
                },
              )
          ),

          const SizedBox(width: 10,),
        ],),
    ]
    ),
        )
    );
  }

}
