import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/model/loan_type_model.dart';
import 'package:kreditoption/model/menu_model.dart';
import 'package:kreditoption/pages/loan_screen.dart';
import 'package:kreditoption/pages/otp_screen.dart';
import 'package:kreditoption/widgets/loan_type_item.dart';
import 'package:kreditoption/widgets/menu_item.dart';
import '../../theme/color.dart';
import '../../utils/dimensions.dart';
import '../controller/auth_controller.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';
import 'loan_emi_screen.dart';

class LoanTypeScreen extends StatefulWidget {
  const LoanTypeScreen({Key? key}) : super(key: key);

  @override
  _LoanTypeScreenState createState() => _LoanTypeScreenState();
}

class _LoanTypeScreenState extends State<LoanTypeScreen> {

  String username="";
  String amountinword="";
/*
  final TextEditingController _phoneController=  TextEditingController();
  final TextEditingController _nameController=  TextEditingController();
  final  FocusNode _phoneNode=  FocusNode();
  final  FocusNode _nameNode=  FocusNode();
*/
  List<LoanTypeModel> _menuModel=[];
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().getLoanType(context).then((value)  async {
      value.body.forEach((data)=>_menuModel.add(LoanTypeModel.fromJson(data)));
      setState(() {
      });
    });
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Column(children: <Widget>[
         Container(
           decoration: const BoxDecoration(
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
        const SizedBox(height: 20,),



        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child:_menuModel.isNotEmpty? ListView.builder(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            itemCount: _menuModel.length,
            shrinkWrap:true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return LoanTypeItem(
                data:  _menuModel.elementAt(index),
                onTap: () {
                  Get.find<AuthController>().saveUserLoanCharge(_menuModel.elementAt(index).charge.toString());
                  Get.find<AuthController>().saveUserLoanType(_menuModel.elementAt(index).name.toString());

                  Navigator.push(context, MaterialPageRoute(builder: (
                        context) => LoanScreen(id:_menuModel.elementAt(index).id!,roi:_menuModel.elementAt(index).roi!,loanType: _menuModel.elementAt(index).name,),));

                },
              );
            },
          ):const Center(child:Text("No Data Available", style: TextStyle(color: appBgColor),) ,),
        ),

    ]
    ),),
    );
  }
}
