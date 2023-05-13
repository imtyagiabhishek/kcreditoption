import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/pages/otp_screen.dart';
import '../../theme/color.dart';
import '../controller/auth_controller.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String amountinword = "";
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  bool value = false;
  TextStyle defaultStyle = const TextStyle(color: Colors.black, fontSize: 16.0);
  TextStyle linkStyle = const TextStyle(color: appBgColor, fontSize: 16.0);
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
                bottomLeft: Radius.elliptical(230, 70),
                bottomRight: Radius.elliptical(230, 70)),
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
                      height: 150,
                      width: 150,
                    )),
              ])),
              Center(
                  child: Column(children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Image.asset(
                      Images.loginImage,
                      height: 200,
                      width: 300,
                    )),
              ])),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: const [
              Text(
                "Login into kredit Option",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: appBgColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "login through mobile number in kredit option",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: TextField(
                controller: _phoneController,
                focusNode: _phoneNode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  filled: true,
                  fillColor: fillColor,
                  labelStyle: TextStyle(color: inActiveColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: inActiveColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: inActiveColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: inActiveColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: inActiveColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: inActiveColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: inActiveColor)),
                ),
                onChanged: (text) {
                  setState(() {
                    username = text;
                  });
                },
              )),
        ])),
        const SizedBox(
          height: 1,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Checkbox(
                value: this.value,
                onChanged: (value) {
                  this.value = value!;
                  setState(() {});
                }),
            const SizedBox(
              width: 1,
            ),
            RichText(
              text: TextSpan(
                style: defaultStyle,
                children: <TextSpan>[
                  const TextSpan(text: 'I have read all '),
                  TextSpan(
                      text: 'terms & condition',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 16,
                                child: Container(
                                  height: 600.0,
                                  width: 360.0,
                                  child: ListView(
                                    children: <Widget>[
                                      const SizedBox(height: 20),
                                      const Center(
                                        child: Text(
                                          "Terms & Conditions",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                              AppConstants.TERMSANDCONDITION)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
                child: IconButton(
              icon: Image.asset(Images.getOTP),
              iconSize: 50,
              onPressed: () {
                if (_phoneController.text.length != 10) {
                  var snackBar = const SnackBar(
                    content: Text("Enter valid phone no"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (value == false) {
                  var snackBar = const SnackBar(
                    content: Text("Please check terms & Conditions"),
                    duration: Duration(seconds: 3),
                    backgroundColor: true ? Colors.red : Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Get.find<AuthController>()
                      .register(_phoneController.text, context);
                }
              },
            )),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ]),
    );
  }
}
