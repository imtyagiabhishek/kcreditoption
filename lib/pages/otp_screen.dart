import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../theme/color.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../controller/auth_controller.dart';

class OTPScreen extends StatefulWidget {
  String? phone;
  OTPScreen({Key? key, this.phone}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FocusNode _otpFocus = FocusNode();

  String otp = "";
  final TextEditingController _otpController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
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
                          Images.otpImage,
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
                children: [
                  const Text(
                    "Enter Verification Code",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: appBgColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Enter OTP sent to +91 " + widget.phone.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 35),
                      child: PinCodeTextField(
                        length: 6,
                        controller: _otpController,
                        focusNode: _otpFocus,
                        appContext: context,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.slide,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 40,
                          fieldWidth: 40,
                          borderWidth: 1,
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          selectedColor: fillColor,
                          selectedFillColor: fillColor,
                          inactiveFillColor: appBgColor.withOpacity(0.2),
                          inactiveColor: appBgColor.withOpacity(0.2),
                          activeColor: appBgColor.withOpacity(0.4),
                          activeFillColor: appBgColor.withOpacity(0.2),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        onChanged: (data) {
                          otp = data.toString();
                        },
                        beforeTextPaste: (text) => true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                    child: IconButton(
                  icon: Image.asset(Images.continueImage),
                  iconSize: 50,
                  onPressed: () {
                    if (_otpController.text.length == 6) {
                      Get.find<AuthController>().verifyPhone(
                        _otpController.text,
                        widget.phone!,
                        context,
                      );

                      //Strictly to be removed latter

/*                      if (widget.phone == '9876543210' &&
                          _otpController.text == '123459') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashBoardScreen()));
                      }
                      */
                      //delete these lines

                    } else {
                      var snackBar = const SnackBar(
                        content: Text("Enter 6 digit otp"),
                        duration: Duration(seconds: 3),
                        backgroundColor: true ? Colors.red : Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                )),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ));
  }
}
