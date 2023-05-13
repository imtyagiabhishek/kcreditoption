import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';
import 'package:kreditoption/pages/insurance_details_screen.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../model/apply_loan_model_response.dart';
import '../model/request/bank_income_request.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';

class BankDetailsScreen extends StatefulWidget {
  BankDetailsScreen(this.applyLoanModel);
  final ApplyLoanResponse applyLoanModel;
  @override
  _BankDetailsScreenState createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {

  bool validateIFSC(String value) {
    String pattern = r'^[A-Za-z]{4}[0-9]{6,7}$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  String username="";
  String amountinword="";
  final TextEditingController _accountNoController=  TextEditingController();
  final TextEditingController _accountHolderNameController=  TextEditingController();
  final TextEditingController _branchController=  TextEditingController();
  final TextEditingController _bankNameController=  TextEditingController();
  final TextEditingController _ifscController=  TextEditingController();
  final TextEditingController _workNatureController=  TextEditingController();
  final TextEditingController _monthlyIncomeController=  TextEditingController();
  final  FocusNode _accountNoNode=  FocusNode();
  final  FocusNode _accountHolderNameNode=  FocusNode();
  final  FocusNode _branchNode=  FocusNode();
  final  FocusNode _bankNameNode=  FocusNode();
  final  FocusNode _ifscNode=  FocusNode();
  final  FocusNode _workNatureNode=  FocusNode();
  final  FocusNode _monthlyIncomeNode=  FocusNode();
  @override
  void initState() {
    super.initState();
    ApplyLoanModel _applyloanmodel= Get.find<AuthController>().appplyloanmodel;
    if(_applyloanmodel.bniDetail!.length>0){
      try {
        _accountHolderNameController.text =_applyloanmodel.bniDetail!.elementAt(0).holderName!;
        _accountNoController.text =_applyloanmodel.bniDetail!.elementAt(0).accountNumber!;
        _ifscController.text=_applyloanmodel.bniDetail!.elementAt(0).ifsc!;
        _branchController.text =_applyloanmodel.bniDetail!.elementAt(0).branchName!;
        _bankNameController.text =_applyloanmodel.bniDetail!.elementAt(0).bankName!;
        _workNatureController.text=_applyloanmodel.bniDetail!.elementAt(0).workNature!;
        _monthlyIncomeController.text=_applyloanmodel.bniDetail!.elementAt(0).monthIncome!.toString();
      }catch(error){}
    }
  }
  final picker = ImagePicker();
  bool value = false;
  XFile? imagefile,imageFileSlip;
  late Future<PickedFile?> pickedFile = Future.value(null);
  late Future<PickedFile?> pickedFileSlip = Future.value(null);
  String selectedValue="Private Firm";
  String _selectedDate="";
  List<String> groupValue= ["Private firm","Government firm","Self Employed"];
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
          Text("Bank & Income Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
          ]),

        const SizedBox(height: 10,),
        Container(child:Row(children: const <Widget>[
              Icon(Icons.account_balance,color: secondary,),
              SizedBox(width: 5,),
              Text("Bank Details",style: TextStyle(color: secondary,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.right,),
             ]),
          margin: EdgeInsets.only(top: 5,left: 20,right: 10),
        ),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                controller: _accountNoController,
                   focusNode: _accountNoNode,
                   keyboardType: TextInputType.number,
                  style:  const TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Your Account number",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
        ),
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Flexible(
                child: TextField(
                    controller: _bankNameController,
                    focusNode: _bankNameNode,
                    keyboardType: TextInputType.text,
                    style:  const TextStyle(color: Colors.black,fontSize: 14),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "Bank Name",
                      filled: true,
                      fillColor: fillColor,
                      labelStyle: TextStyle(color: fillColor,fontSize: 14),
                      contentPadding: EdgeInsets.all(10),
                    )
                ),
              ),
            ],),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 5,left: 10,right: 10),
          ),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                  controller: _accountHolderNameController,
                  focusNode: _accountHolderNameNode,
                  keyboardType: TextInputType.text,
                  style:  const TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Account Holder Name",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
        ),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                  controller: _branchController,
                  focusNode: _branchNode,
                  keyboardType: TextInputType.text,
                  style:  const TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Branch Address",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
        ),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                  controller: _ifscController,
                  focusNode: _ifscNode,
                  keyboardType: TextInputType.text,
                  style:  const TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "IFSC Code",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
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

              GestureDetector( child:  Container(child: Image.asset(Images.passbook),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 5,left: 20,right: 20),),
                  onTap: () async{
                    pickedFile = picker
                        .getImage(
                      source: ImageSource.gallery,
                    )
                        .whenComplete(() {
                      pickedFile.then((value) {
                        print(value!.path);
                        imagefile = XFile(value.path);
                        print(imagefile!.path);
                        Get.find<AuthController>().uploadImagePASSBOOK(imagefile!,widget.applyLoanModel.id!);
                      }
                      );
                      setState(() {});
                    });
                  },)


            ],
          ),

        const SizedBox(height: 10,),
        Container(child:Row(children: const <Widget>[
          Icon(Icons.add_card_rounded,color: secondary,),
          SizedBox(width: 5,),
          Text("Income Details",style: TextStyle(color: secondary,fontWeight: FontWeight.bold, fontSize: 14,),textAlign: TextAlign.right,),
        ]),
          margin: EdgeInsets.only(top: 5,left: 20,right: 10),
        ),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                  controller: _workNatureController,
                  focusNode: _workNatureNode,
                  keyboardType: TextInputType.text,
                  style:  const TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Enter nature of work",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
        ),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                  controller: _monthlyIncomeController,
                  focusNode: _monthlyIncomeNode,
                  keyboardType: TextInputType.number,
                  style:  const TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Gross monthly income",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5,left: 10,right: 10),
        ),
        Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text("Employment status",style: TextStyle(fontSize: 14),),),
                SizedBox(width: 20,),
                Flexible(child:
                Container(child:
                 DropdownButton<String>(
              value: selectedValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 20,
              underline: SizedBox(),
              style: TextStyle(color: Colors.black),
              onChanged: (String? newValue){
                setState(() {
                  print(newValue);
                  selectedValue = newValue!.toString();
                });
              },
              items: <String>["Private Firm","Government Firm","Self Employed"]
                  .map<DropdownMenuItem<String>>((String val){
                // ignore: missing_required_param
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
            ),decoration:
                BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                 padding: EdgeInsets.only(left: 10,right: 10),
                 ),),
               ]),
        ),
       /* Container(child: Image.asset(Images.income),
          margin: EdgeInsets.only(left: 1,right: 1,top: 5),),*/


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<PickedFile?>(
                future: pickedFileSlip,
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
              Container(child: Image.asset(Images.income),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 5,left: 20,right: 20),),
                onTap: () async{
                  pickedFileSlip = picker
                      .getImage(
                    source: ImageSource.gallery,
                  )
                      .whenComplete(() {
                    pickedFileSlip.then((value) {
                      print(value!.path);
                      imageFileSlip = XFile(value.path);
                      print(imageFileSlip!.path);
                      Get.find<AuthController>().uploadImageSLIP(imageFileSlip!,widget.applyLoanModel.id!);
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
                icon: Image.asset(Images.continueImage),
                iconSize: 50,
                onPressed: () {
                  if(_accountNoController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Account No required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_accountHolderNameController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Account Holder Name required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_bankNameController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Bank Name required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_branchController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Branch Address required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_ifscController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("IFSC Code  required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(!validateIFSC(_ifscController.text)){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("IFSC Code is not Valid", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_workNatureController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Work of Nature required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_monthlyIncomeController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Monthly Income required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }/*else if(==''){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Passbook Image File required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }*/
                  else{
                    BankIncomeDetailsRequest bankIncomerequest= BankIncomeDetailsRequest();
                    bankIncomerequest.accountNumber=_accountNoController.text.toString();
                    bankIncomerequest.holderName=_accountHolderNameController.text.toString();
                    bankIncomerequest.ifsc=_ifscController.text.toString();
                    bankIncomerequest.branchName=_branchController.text.toString();
                    bankIncomerequest.bankName=_bankNameController.text.toString();
                    bankIncomerequest.workNature=_workNatureController.text.toString();
                    bankIncomerequest.monthIncome=_monthlyIncomeController.text.toString();
                    bankIncomerequest.jobType=selectedValue;

                    Get.find<AuthController>().bankIncomeDetails(bankIncomerequest,widget.applyLoanModel.id ,context).then((value){
                      if(value.id!.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InsuranceDetailsScreen(widget.applyLoanModel)));
                      }
                      else{
                        var snackBar = SnackBar(content: Text("Please fill all field correctly"),
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
      )
    );
  }

}
