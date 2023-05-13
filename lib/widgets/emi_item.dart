import 'package:flutter/material.dart';
import 'package:kreditoption/model/emi_model.dart';
import 'package:kreditoption/model/menu_model.dart';

import '../theme/color.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';

class EMIItem extends StatelessWidget {
  EMIItem({  Key? key,  required this.data,required this.onTap }) : super(key: key);
  final Emis data;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap:onTap,
        child:
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          decoration: BoxDecoration(color: fillColor ,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.dueDate.toString(), style: TextStyle(color: Colors.black), textAlign: TextAlign.center,) ,

              Text(data.payment.toString(), style: TextStyle(color: Colors.black), textAlign: TextAlign.center,) ,

              Text(data.remark.toString(), style: TextStyle(color: Colors.black), textAlign: TextAlign.center,) ,
            ],),
        ),
      );
  }
}