import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    //notification
  return  Column( children: [
      Container(child:
      Text("Home",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
        margin: EdgeInsets.only(left: 20,right: 20),
      ),

      SizedBox(height: 20,),
      Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("State bank of india",style: TextStyle(color: secondary, fontSize: 18,),textAlign: TextAlign.left,),
            SizedBox(height: 10,),
            Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visualform of a document or a typeface without relying on  ",maxLines: 5,style: TextStyle(color: Colors.black, fontSize: 12,),textAlign: TextAlign.left,),
          ],) ,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: third),
      ),
      SizedBox(height: 20,),
      Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("State bank of india",style: TextStyle(color: secondary, fontSize: 18,),textAlign: TextAlign.left,),
            SizedBox(height: 10,),
            Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visualform of a document or a typeface without relying on  ",maxLines: 5,style: TextStyle(color: Colors.black, fontSize: 12,),textAlign: TextAlign.left,),
          ],) ,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: third),
      ),
      SizedBox(height: 20,),
      Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("State bank of india",style: TextStyle(color: Colors.grey, fontSize: 18,),textAlign: TextAlign.left,),
            SizedBox(height: 10,),
            Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visualform of a document or a typeface without relying on  ",maxLines: 5,style: TextStyle(color: Colors.grey, fontSize: 12,),textAlign: TextAlign.left,),
          ],) ,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: fillColor),
      ),
      SizedBox(height: 20,),
      Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("State bank of india",style: TextStyle(color: Colors.grey, fontSize: 18,),textAlign: TextAlign.left,),
            SizedBox(height: 10,),
            Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visualform of a document or a typeface without relying on  ",maxLines: 5,style: TextStyle(color: Colors.grey, fontSize: 12,),textAlign: TextAlign.left,),
          ],) ,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: fillColor),
      ),
    ],);
    //end notification
  }
}