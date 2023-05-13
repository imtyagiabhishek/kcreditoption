import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/widgets/notification_item.dart';

import '../controller/auth_controller.dart';
import '../model/notification_model.dart';
import '../theme/color.dart';
import '../utils/dimensions.dart';
class NotificationScreen extends StatefulWidget {
  NotificationScreen ({Key? key}) : super(key: key);

  @override
  _NotificationScreen createState() => _NotificationScreen();
}
class _NotificationScreen extends  State<NotificationScreen >{
  List<NotificationModel> notificationModel=[];
  bool load=false;
  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getNotification().then((value) async {
     notificationModel=value;
     load=true;
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {

    //notification
  return  Column( children: [
      Container(child:
      Text("Notification",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
        margin: EdgeInsets.only(left: 20,right: 20),
      ),
      load?SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      child:notificationModel.isNotEmpty? ListView.builder(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        itemCount: notificationModel.length,
        shrinkWrap:true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return NotificationItem(
            data:  notificationModel.elementAt(index),
            onTap: () {

            },
          );
        },
      ):Center(child:Text("No Data Available", style: TextStyle(color: appBgColor),) ,),
    ):CircularProgressIndicator(),
      /*SizedBox(height: 20,),
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
      ),*/
    ],);
    //end notification
  }
}