import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';
import 'package:kreditoption/pages/loan_details_screen.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../model/apply_loan_model_response.dart';
import '../model/request/insurance_request.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';

class InsuranceDetailsScreen extends StatefulWidget {
  InsuranceDetailsScreen(this.applyLoanModel);
  final ApplyLoanResponse applyLoanModel;
  @override
  _InsuranceDetailsScreenState createState() => _InsuranceDetailsScreenState();
}

class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> {

  String username="";
  String amountinword="";
  final TextEditingController _nameController=  TextEditingController();
  final TextEditingController _amountController=  TextEditingController();
  final TextEditingController _relationController=  TextEditingController();
  final  FocusNode _nameNode=  FocusNode();
  final  FocusNode _amountNode=  FocusNode();
  final  FocusNode _relationNode=  FocusNode();
  @override
  void initState() {
    super.initState();
    ApplyLoanModel _applyloanmodel= Get.find<AuthController>().appplyloanmodel;
    if(_applyloanmodel.insuranceDetail!.length>0){
      try {
        _nameController.text =_applyloanmodel.insuranceDetail!.elementAt(0).name!;
        _relationController.text =_applyloanmodel.insuranceDetail!.elementAt(0).relation!;
        _selectedDate=_applyloanmodel.insuranceDetail!.elementAt(0).dob!;
        _selectedDateFormat=_applyloanmodel.insuranceDetail!.elementAt(0).dob!;
        _amountController.text =_applyloanmodel.insuranceDetail!.elementAt(0).amount!.toString();
      }catch(error){}
    }
  }
  bool value = false;

  String selectedValue="Male";
  String _selectedDate="",_selectedDateFormat="";
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
          Text("Insurance Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
          ]),

        const SizedBox(height: 10,),

        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                controller: _nameController,
                   focusNode: _nameNode,
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
                    hintText: "Nominee name",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child:   GestureDetector(
                  onTap: (){

                    _selectDate(context);
                  },
                  child: Container(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedDate.isEmpty?"Date of Birth":""+_selectedDate,style: TextStyle(color: darker,fontSize: 14),),
                      Align(
                        alignment: Alignment. topRight,
                        child: Image.asset(Images.calender),)
                    ],),
                    decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(10),
                  ),
                ),),
                SizedBox(width: 20,),
                Flexible(child:  Container(child:
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
                  items: <String>["Male","Female","Other"]
                      .map<DropdownMenuItem<String>>((String val){
                    // ignore: missing_required_param
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                ),decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.only(left: 40,right: 40),
                ),),

              ],),),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(
              child: TextField(
                  controller: _relationController,
                  focusNode: _relationNode,
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
                    hintText: "Relation with nominee",
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
                  controller: _amountController,
                  focusNode: _amountNode,
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
                    hintText: "Insurance amount",
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
          const SizedBox(height: 10,),
       
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
                  if(_nameController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Nominee Name required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }

                  else if(_relationController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Relation required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_amountController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Insurance Amount required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_selectedDateFormat.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Date of birth required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else{
                    InsuranceDetailsRequest insurancedetails= InsuranceDetailsRequest();
                    insurancedetails.name=_nameController.text.toString();
                    insurancedetails.dob=_selectedDateFormat;
                    insurancedetails.relation=_relationController.text.toString();
                    insurancedetails.amount=_amountController.text.toString();
                    insurancedetails.gender=selectedValue;

                    Get.find<AuthController>().insuranceDetails(insurancedetails,widget.applyLoanModel.id ,context).then((value){
                      if(value.id!.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoanDetailsScreen(widget.applyLoanModel)));
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
  getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
  getFormatedDateOther(_date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker( //we wait for the dialog to return
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime(2005),
    );
    if (d != null) {
      setState(() {
        // we format the selected date and assign it to the state variable
        _selectedDate = getFormatedDate(d.toString());
        _selectedDateFormat = getFormatedDateOther(d.toString());

      });
    }
  }
}
