import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditoption/pages/login_screen.dart';

import '../controller/auth_controller.dart';
import '../theme/color.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';
import 'landing_page.dart';
import 'option_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _route();
  }

  void _route() {
    Timer(const Duration(seconds: 5), () async {

      if (Get.find<AuthController>().isLoggedIn()) {

     //   Get.find<AuthController>().saveUserLoanId("9201c019-a1ab-48ab-ad8c-be681ade9d76");
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => OptionScreen()));

      }else {
        if (Get.find<AuthController>().isFirst()) {

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => LandingPage()));

        }else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => LoginScreen()));
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body:  Column(children: <Widget>[

        SizedBox(height: 400),
        Expanded(
           child:
               Center(child:
               ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(Images.logo, width: 150,height: 150,)),
                   ),

           ),
        Expanded(
            child:  Align(
                alignment: Alignment.bottomCenter,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("app version 1.1",  textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15,),)
                  ],
                )
            )
        )
      ]
    ),
    );
  }
}
