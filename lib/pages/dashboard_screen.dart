import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/pages/emi_status_screen.dart';
import 'package:kreditoption/pages/help_screen.dart';
import 'package:kreditoption/pages/notification_screen.dart';
import 'package:kreditoption/pages/wallet_screen.dart';
import 'package:kreditoption/theme/color.dart';

import '../controller/auth_controller.dart';
import '../model/apply_loan_model.dart';
import '../utils/images.dart';
import 'home_screen.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen ({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen > {
  int _selectedIndex = 0;
  ApplyLoanModel applyLoanModel= ApplyLoanModel();
   final List<Widget> _widgetOptions = <Widget>[
    MyWalletScreen(),
    EMIStatusScreen(),
   // HomeScreen(),
    NotificationScreen(),
    HelpScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (child: Center(
        child:

        Column(children: [
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
           SizedBox(height: 20,),
          _widgetOptions.elementAt(_selectedIndex),

        ],),


      )),
      bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon:Icon(Icons.account_balance_wallet,color:secondary) ,
                icon: Icon(Icons.account_balance_wallet,color: Colors.grey,),
                label: 'Wallet',
                backgroundColor: fillColor
            ),
            BottomNavigationBarItem(
              activeIcon:Icon(Icons.replay_circle_filled,color:secondary) ,
              icon: Icon(Icons.replay_circle_filled,color: Colors.grey,),
              label: 'Pay EMI',
              backgroundColor: fillColor,
            ),
            /*BottomNavigationBarItem(
                activeIcon:Icon(Icons.home,color:secondary) ,
                icon: Icon(Icons.home,color: Colors.grey,),
                label: 'Home',
                backgroundColor:fillColor
            ),*/
            BottomNavigationBarItem(
                activeIcon:Icon(Icons.notifications,color:secondary) ,
                icon: Icon(Icons.notifications,color: Colors.grey,),
                label: 'Notification',
                backgroundColor:fillColor
            ),
            BottomNavigationBarItem(
              activeIcon:Icon(Icons.comment_bank_rounded,color:secondary) ,
              icon: Icon(Icons.comment_bank_rounded,color: Colors.grey,),
              label: 'Help',
              backgroundColor: fillColor,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: secondary,
          iconSize: 25,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}