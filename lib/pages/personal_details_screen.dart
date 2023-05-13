import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kreditoption/pages/kyc_details_screen.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../model/apply_loan_model_response.dart';
import '../model/request/personal_details_request.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class PersonalDetailsScreen extends StatefulWidget {
  PersonalDetailsScreen(this.applyLoanModel);
  final ApplyLoanResponse applyLoanModel;
  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}
enum GENDER {Male, Female, Other }
class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {

  String username="";
  String amountinword="";
  final picker = ImagePicker();
  XFile? imagefile;
  final TextEditingController _emailController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final TextEditingController _stateController=  TextEditingController();
  final TextEditingController _districtController=  TextEditingController();
  final TextEditingController _cityController=  TextEditingController();
  final TextEditingController _pincodeController=  TextEditingController();
  final TextEditingController _addressController=  TextEditingController();
  final  FocusNode _emailNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  final  FocusNode _stateNode=  FocusNode();
  final  FocusNode _districtNode=  FocusNode();
  final  FocusNode _cityNode=  FocusNode();
  final  FocusNode _pincodeNode=  FocusNode();
  final  FocusNode _addressNode=  FocusNode();

  String imageurl="";
  @override
  void initState() {
    super.initState();
   ApplyLoanModel _applyloanmodel= Get.find<AuthController>().appplyloanmodel;
   if(_applyloanmodel.personalDetail!.length>0){
     try {
       _nameController.text =_applyloanmodel.personalDetail!.elementAt(0).name!;
       _emailController.text =_applyloanmodel.personalDetail!.elementAt(0).email!;
       _pincodeController.text=_applyloanmodel.personalDetail!.elementAt(0).pincode!;
       _stateController.text =_applyloanmodel.personalDetail!.elementAt(0).state!;
       _cityController.text =_applyloanmodel.personalDetail!.elementAt(0).city!;
       _districtController.text=_applyloanmodel.personalDetail!.elementAt(0).district!;
       _addressController.text=_applyloanmodel.personalDetail!.elementAt(0).address!;
       _selectedDateFormat=_applyloanmodel.personalDetail!.elementAt(0).dob!;
       _selectedDate=_applyloanmodel.personalDetail!.elementAt(0).dob!;

       imageurl=_applyloanmodel.personalDetail!.elementAt(0).profile!;
       setState(() {
       });
     }catch(error){

     }
   }
  }
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  bool value = false;

  String selectedValue="Male";
  String _selectedDate="",_selectedDateFormat="";
  List<String> groupValue= ["Male","Female","Other"];
  late Future<PickedFile?> pickedFile = Future.value(null);
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
          Text("Personal Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.center,),
        ])),


        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<PickedFile?>(
              future: pickedFile,
              builder: (context, snap) {
                if (snap.hasData) {
                  return Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: fillColor,
                      child: ClipOval(
                        child:SizedBox(
                            width: 100.0,
                            height: 100.0,
                            child: Image.file(
                              File(snap.data!.path),
                              fit: BoxFit.contain,)
                        ),
                      ),
                    ),
                  );
                }
                return Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: fillColor,
                    child: ClipOval(
                      child:SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: imageurl==''?
                          Image.asset(Images.user,):Image.network(imageurl)
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                pickedFile = picker
                    .getImage(
                  source: ImageSource.gallery,
                )
                    .whenComplete(() {
                      pickedFile.then((value) {
                        print(value!.path);
                        imagefile = XFile(value.path);
                        print(imagefile!.path);
                        imageurl=imagefile!.path;
                        Get.find<AuthController>().uploadImage(imagefile!,widget.applyLoanModel.id!);
                      }
                      );
                      setState(() {});
                    });
              },
              icon:Icon(Icons.add_a_photo),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                controller: _nameController,
                  focusNode: _nameNode,
                  style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Your Name",
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
    /*      Flexible(child:  GestureDetector(
          onTap: (){
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
                       // _buildRow( 'Female'),
                       // _buildRow( 'Other'),
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
              Text(selectedValue.isEmpty?"Gender":selectedValue,style: TextStyle(color:darker,fontSize: 14),),
              Align(
                alignment: Alignment. topRight,
                child: Image.asset(Images.expandArrow),)
            ],),
            decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: EdgeInsets.all(10),
          ),
        ),)*/
      ],),),
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                controller: _emailController,
                  focusNode: _emailNode,
                  style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Email",
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
        Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                controller: _addressController,
                  focusNode: _addressNode,
                  style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Address",
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
        Container(child:
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>  [
            Flexible(
              child: TextField(
                controller: _stateController,
                  focusNode: _stateNode,
                  style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "State",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
             SizedBox(width: 20.0,),
             Flexible(
              child: TextField(
                controller: _districtController,
                focusNode: _districtNode,
                style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                        ),
                    ),
                      hintText: "District",
                      filled: true,
                      fillColor: fillColor,
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 14),
                      contentPadding: EdgeInsets.all(10),
                    )
                   ),
            ),
          ],
        ),
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
        ),
        Container(child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>  [
            Flexible(
              child: TextField(
                  controller: _cityController,
                  focusNode: _cityNode,
                  style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "City",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
            SizedBox(width: 20.0,),
            Flexible(
              child:
              TextField(
                controller: _pincodeController,
                  focusNode: _pincodeNode,
                  keyboardType:TextInputType.number,
                  style:  TextStyle(color: Colors.black,fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Pin code",
                    filled: true,
                    fillColor: fillColor,
                    labelStyle: TextStyle(color: fillColor,fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
            ),
          ],
        ),
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
        ),
        Row( children:  [
          SizedBox(width: 10,),
          Expanded(
              child: IconButton(
                icon: Image.asset(Images.continueImage),
                iconSize: 50,
                onPressed: () {

                  if(_nameController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Full Name required", style: TextStyle(color: Colors.white)),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        ));
                  }else if(_selectedDateFormat==""){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Date of Birth required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(_emailController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Email id required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(!validateEmail(_emailController.text)){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Email Id is not valid', style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(_addressController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Address required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_stateController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("State required", style: TextStyle(color: Colors.white)),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        ));
                  }
                  else if(_districtController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("District required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }
                  else if(_cityController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("City required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(_pincodeController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Pin code required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else if(_pincodeController.text.length!=6){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Pin code not valid", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  } else if(imageurl==''){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Image File required", style: TextStyle(color: Colors.white)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    ));
                  }else{
                    PersonalDetailsRequest personalDetails= PersonalDetailsRequest();
                    personalDetails.name=_nameController.text.toString();
                    personalDetails.email=_emailController.text.toString();
                    personalDetails.city=_cityController.text.toString();
                    personalDetails.district=_districtController.text.toString();
                    personalDetails.state=_stateController.text.toString();
                    personalDetails.dob=_selectedDateFormat;
                    personalDetails.gender=selectedValue;
                    personalDetails.address=_addressController.text.toString();
                    personalDetails.pincode=_pincodeController.text.toString();
                    Get.find<AuthController>().personalDetails(personalDetails,widget.applyLoanModel.id ,context).then((value){
                      if(value.id!.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KYCDetailsScreen(widget.applyLoanModel)));
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
        ),
    );
  }
  Widget _buildRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ListTile(
           leading: Radio<String>(
        value: 'Male',
        groupValue: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value!;
          });
        },
      ),
           title: const Text('Male'),
      ),
          ListTile(
            leading: Radio<String>(
              value: 'Female',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
            title: const Text('Female'),
          ),
          ListTile(
            leading: Radio<String>(
              value: 'Other',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
            title: const Text('Other'),
          ),
        ],
      ),
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
