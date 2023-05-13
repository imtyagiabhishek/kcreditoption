import 'package:flutter/material.dart';
import 'package:kreditoption/model/menu_model.dart';
import 'package:kreditoption/model/notification_model.dart';

import '../theme/color.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({  Key? key, required this.data,required this.onTap }) : super(key: key);
  final NotificationModel data;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.title.toString(),style: TextStyle(color: secondary, fontSize: 18,),textAlign: TextAlign.left,),
            SizedBox(height: 10,),
            Text(data.desc.toString(),maxLines: 5,style: TextStyle(color: Colors.black, fontSize: 12,),textAlign: TextAlign.left,),
          ],) ,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: third),
      );
  }
}