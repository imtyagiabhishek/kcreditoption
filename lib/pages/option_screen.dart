import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/model/menu_model.dart';
import 'package:kreditoption/pages/dashboard_screen.dart';
import 'package:kreditoption/pages/loan_screen.dart';
import 'package:kreditoption/pages/loan_type_screen.dart';
import 'package:kreditoption/pages/otp_screen.dart';
import 'package:kreditoption/widgets/menu_item.dart';
import '../../theme/color.dart';
import '../../utils/dimensions.dart';
import '../controller/auth_controller.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';
import 'loan_emi_screen.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  String username = "";
  String amountinword = "";
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  List<MenuModel> _menuModel = [];
  @override
  void initState() {
    super.initState();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.subscribeToTopic('all');
    Get.find<AuthController>().getMenu(context).then((value) async {
      value.body.forEach((data) => _menuModel.add(MenuModel.fromJson(data)));
      setState(() {});
    });
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: appBgColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(230, 50),
                bottomRight: Radius.elliptical(230, 50)),
          ),
          child: Column(
            children: [
              Center(
                  child: Column(children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Image.asset(
                      Images.logo,
                      height: 100,
                      width: 100,
                    )),
              ])),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        /* Center(child: Column(children: <Widget>[

          GestureDetector(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (
               context) => LoanEMIScreen()));
         },
         child:
         Container(
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.all(20),
              child:
              Column(children: [
                Image.asset(Images.calculator,height: 120,width: 160,),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: secondary ,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
                  ),
                  child: Text("EMI Calculator  >>", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,
                )
              ],),
          ),
           ),

          GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (
                context) => LoanScreen()));
          },
          child: Container(
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: const EdgeInsets.all(20),
                  child:Column(children: [
                    Image.asset(Images.loan,height: 120,width: 160),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: secondary ,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
                      ),
                      child: Text("Loan Platform >>", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,) ,
                    )
                  ],),
                )
          )

        ])),*/

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          child: _menuModel.isNotEmpty
              ? ListView.builder(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  itemCount: _menuModel.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return kMenuItem(
                      data: _menuModel.elementAt(index),
                      onTap: () {
                        if (_menuModel.elementAt(index).url ==
                            'emi_calculator') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoanEMIScreen()));
                        } else if (_menuModel.elementAt(index).url ==
                            'loan_platform') {
                          if (Get.find<AuthController>().getUserLoanStatus() ==
                              "0") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoanTypeScreen()));
                          } else if (Get.find<AuthController>()
                                  .getUserLoanStatus() ==
                              "1") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashBoardScreen()));
                          }
                        }
                      },
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No Data Available",
                    style: TextStyle(color: appBgColor),
                  ),
                ),
        ),
      ]),
    );
  }
}
