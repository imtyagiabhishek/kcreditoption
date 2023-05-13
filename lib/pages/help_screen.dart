import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/auth_controller.dart';
import '../theme/color.dart';
import '../utils/images.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen ({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}
class _HelpScreenState extends  State<HelpScreen > {


  final TextEditingController _emailController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final TextEditingController _subjectController=  TextEditingController();
  final TextEditingController _bodyController=  TextEditingController();

  final  FocusNode _emailNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
  final  FocusNode _subjectNode=  FocusNode();
  final  FocusNode _bodyNode=  FocusNode();
  @override
  Widget build(BuildContext context) {

    //notification
    //Help
   return Column(children:[
      Container(child:
      Text("Help",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
        margin: EdgeInsets.only(left: 20,right: 20),
      ),

      SizedBox(height: 10,),

      Container(child:
      Text("Feel free to contact us with your questions & we will get back to you as soon as possible.",maxLines: 2,style: TextStyle(color: Colors.grey, fontSize: 12,),textAlign: TextAlign.left,),
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
      ),
      Container(child:
      Text("How can we help you?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
        margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
      ),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextField(
               controller: _nameController,
               focusNode: _nameNode,
                keyboardType: TextInputType.text,
                style:  TextStyle(color: Colors.grey,fontSize: 14),
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
                )
            ),
          ),
        ],),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
      ),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextField(
              controller: _emailController,
                focusNode: _emailNode,
                keyboardType: TextInputType.text,
                style:  TextStyle(color: Colors.grey,fontSize: 14),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Your Email",
                  filled: true,
                  fillColor: fillColor,
                  labelStyle: TextStyle(color: fillColor,fontSize: 14),
                )
            ),
          ),
        ],),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
      ),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextField(
              controller: _subjectController,
                focusNode: _subjectNode,
                keyboardType: TextInputType.number,
                style:  TextStyle(color: Colors.grey,fontSize: 14),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Your Phone No",
                  filled: true,
                  fillColor: fillColor,
                  labelStyle: TextStyle(color: fillColor,fontSize: 14),
                )
            ),
          ),
        ],),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
      ),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextField(

              controller: _bodyController,
                focusNode: _bodyNode,
                keyboardType: TextInputType.text,
                maxLines: 5,
                style:  TextStyle(color: Colors.grey,fontSize: 14),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Your message",
                  filled: true,
                  fillColor: fillColor,
                  labelStyle: TextStyle(color: fillColor,fontSize: 14),
                )
            ),
          ),
        ],),
        decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
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
                var snackBar = SnackBar(content: Text("Title required"),
                duration: Duration(seconds: 3),
                backgroundColor: true ? Colors.red : Colors.green,);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else if(_emailController.text.isEmpty) {
                  var snackBar = SnackBar(content: Text("Email required"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else if(_emailController.text.isEmpty) {
                  var snackBar = SnackBar(content: Text("Phone No required"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else if(_bodyController.text.isEmpty) {
                  var snackBar = SnackBar(content: Text("Message required"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else {
                  Get.find<AuthController>().sendEmail(
                      _emailController.text.toString(),
                      _nameController.text.toString(),
                      _nameController.text.toString() + " " +
                          _subjectController.text.toString(),
                      _bodyController.text.toString(), context);
                }

              },
            )
        ),

        SizedBox(width: 10,),
      ],),
    ]
    );
    //End Help
    //end notification
  }
}