import 'package:flutter/material.dart';
import 'package:kreditoption/model/loan_type_model.dart';
import 'package:kreditoption/model/menu_model.dart';

import '../theme/color.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';

class LoanTypeItem extends StatelessWidget {
  const LoanTypeItem({  Key? key,  this.image,required this.data, this.description,required this.onTap }) : super(key: key);
  final LoanTypeModel data;
  final  image;
  final description;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap:onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.all(20),
          child:
          Column(children: [
            data.image!=null?
            Image.network(data.image!,height: 120,width: double.infinity,fit: BoxFit.cover,):
            const SizedBox(height: 120,width: double.infinity,),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: secondary ,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
              ),
              child: Text(data.name!+" >>", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,
            )
          ],),
        ),
      );
  }
}