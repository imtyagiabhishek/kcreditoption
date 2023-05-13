import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/slider.dart';
import '../../theme/color.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
     // crossAxisAlignment: CrossAxisAlignment.center,
     // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       /* Container(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(sliderArrayList[index].sliderImageUrl!))),
        ),*/
        Container(
          decoration: BoxDecoration(
            color: appBgColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(230,70),bottomRight:Radius.elliptical(230,70)),
          ),
          child:Column(children: [
            Center(child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  child:Image.asset(Images.logo,height: 150,width: 150,)),
            ])),
            Center(child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  child:Image.asset(sliderArrayList[index].sliderImageUrl!,height: 200,width: 300,)),
            ])),
          ],),

        ),
        SizedBox(
          height: 60.0,
        ),
        Text(
          sliderArrayList[index].sliderHeading!,
          style: TextStyle(
            fontFamily: AppConstants.POPPINS,
            fontWeight: FontWeight.w700,
            fontSize: 20.5,
            color: secondary
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              sliderArrayList[index].sliderSubHeading!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
