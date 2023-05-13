import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kreditoption/utils/images.dart';
import 'package:timelines/timelines.dart';

import '../theme/color.dart';

class MyWalletConfirmScreen extends StatelessWidget {
  const MyWalletConfirmScreen({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> _name=["Loan \nDetails","Basic \nInformation","KYC \nDetails","Loan\nApproval","Confirmation\nCall/SMS","Loan\nDisbursement"];

    //notification
  return Column( children: [
    Container(child:
    Text("My Wallet",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.left,),
      margin: EdgeInsets.only(left: 20,right: 20),
    ),
    Container(
      width:double.infinity ,
      height: 60,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
      child:Timeline.tileBuilder(
          theme: TimelineThemeData(
              direction: Axis.horizontal,
              connectorTheme: ConnectorThemeData(
                color: Colors.white,
                space: 10.0,
                thickness: 2.0,
              ),
              nodePosition: 0,
              indicatorTheme: IndicatorThemeData(
                  color: Colors.white
              )
          ),

          builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.basic,
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(5),
              child: Text(_name.elementAt(index),style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
            ),
            itemCount: _name.length,
          )
      ),),
    Container(
      child:
      Row(
          children:[
            Image.asset(Images.verification),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CONGRATULATION!",style: TextStyle(color: secondary, fontSize: 18,),textAlign: TextAlign.left,),
                SizedBox(height: 5,),
                Text("YOUR LOAN APPLICATION HAS BEEN APPROVED! (On Condition)",maxLines: 2,style: TextStyle(color: Colors.black, fontSize: 9,),textAlign: TextAlign.left,),
              ],),
          ]
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20,right: 20),
    ),
    Stack(children: [
      Container(
        height: 200,
        width: double.infinity,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Images.userImage,height: 80,),
            Text("Hello Abc",style: TextStyle(color: Colors.white, fontSize: 18,)),
            SizedBox(height: 5,),
            Text("Loan account iD : 1234567890",maxLines: 5,style: TextStyle(color: Colors.white, fontSize: 12,)),
            SizedBox(height: 5,),
            Text("Loan Wallet iD : 1234567890",maxLines: 5,style: TextStyle(color: Colors.white, fontSize: 12,)),
          ],) ,
        padding: EdgeInsets.only(bottom: 50,top: 10,right: 10,left: 10),
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(Images.background),
            fit: BoxFit.cover,
          ),),
      ),
      Container(alignment: Alignment.topCenter,
        padding: new EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .20,),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("YOUR REQUESTED LOAN AMOUNT :",style: TextStyle(color: Colors.black, fontSize: 14,),textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                  Text("10000 ",maxLines: 5,style: TextStyle(color: secondary, fontSize: 16,),textAlign: TextAlign.left,),
                ],) ,
                padding: EdgeInsets.only(top: 10,left: 10,bottom: 10,right: 0),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_outlined,color: Colors.white,),
                    SizedBox(height: 10,),
                    Text("Approved ",maxLines: 5,style: TextStyle(color: Colors.white, fontSize: 16,),textAlign: TextAlign.left,),
                  ],) ,
                decoration: BoxDecoration(color: Colors.green ,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight:Radius.circular(10)),
                ),
                padding: EdgeInsets.all(10),
              )
            ],),
          margin: EdgeInsets.only(left: 30,right: 30),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: fillColor),
        ),),


    ],),
  /*  SizedBox(height: 10,),
    Image.asset(Images.viewWallet),
*/
    Container(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text("Step 1", style: TextStyle(color: Colors.white),),
          decoration: BoxDecoration(color: secondary,borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(5), ),
        Text("Read the terms & condition carefully",style: TextStyle(color: Colors.grey,fontSize: 14),),
        Align(
          alignment: Alignment. topRight,
          child: Icon(Icons.check_circle,color: Colors.green,),)
      ],),
      decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
    ),
    Container(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text("Step 2", style: TextStyle(color: Colors.white),),
          decoration: BoxDecoration(color: secondary,borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(5), ),
        Text("Enter credit score",style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.left,),
        Align(
          alignment: Alignment. topRight,
          child: Image.asset(Images.expandArrow),)
      ],),
      decoration: BoxDecoration(color: fillColor,borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
    ),

  ],);

    //end notification
  }
}