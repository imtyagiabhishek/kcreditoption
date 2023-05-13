import 'package:flutter/material.dart';
import 'package:kreditoption/pages/apply_loan_screen.dart';
import 'package:kreditoption/pages/loan_emi_report_screen.dart';

import 'package:kreditoption/pages/otp_screen.dart';
import 'package:timelines/timelines.dart';
import '../../theme/color.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import '../widgets/my_separator.dart';

class LoanEMIScreen extends StatefulWidget {
  @override
  _LoanEMIScreenState createState() => _LoanEMIScreenState();
}

class _LoanEMIScreenState extends State<LoanEMIScreen> {
  String username = "";
  String amountinword = "";
  final TextEditingController _downPaymentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final FocusNode _amountNode = FocusNode();
  final FocusNode _rateNode = FocusNode();
  final FocusNode _downPaymentNode = FocusNode();
  bool personal = true, home = false, car = false, education = false;
  @override
  void initState() {
    super.initState();
  }

  final List<String> _name = [
    "Loan \nDetails",
    "Basic \nInformation",
    "KYC \nDetails",
    "Loan\nApproval",
    "Confirmation\nCall/SMS",
    "Loan\nDisbursement"
  ];
  bool value = false;

  int valueHolder = 1000;
  int valueTime = 5;

  double selectedValueYear = 0;
  List<String> groupValueYear = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20"
  ];
  List<String> groupValueYearList = [
    "1 Year",
    "2 Years",
    "3 Years",
    "4 Years",
    "5 Years",
    "6 Years",
    "7 Years",
    "8 Years",
    "9 Years",
    "10 Years",
    "11 Years",
    "12 Years",
    "13 Years",
    "14 Years",
    "15 Years",
    "16 Years",
    "17 Years",
    "18 Years",
    "19 Years",
    "20 Years"
  ];

  double selectedValue = 0;
  List<String> groupValue = [
    "Personal",
    "Education",
    "Business",
    "Care",
    "Bike",
    "Electronics Gadgets"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(children: <Widget>[
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
            Container(
              child: const Text(
                "Loan EMI Calculator",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.only(left: 20, right: 20),
            ),
            const SizedBox(height: 20),
            Row(children: const [
              SizedBox(
                width: 20,
              ),
              Text(
                "Select Loan Type :",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    GestureDetector(
                      child: Container(
                        height: 60,
                        width: 75,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: red),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            Text(
                              "Personal",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        car = false;
                        personal = true;
                        education = false;
                        home = false;
                        setState(() {});
                      },
                    ),
                    personal
                        ? const Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.check_circle,
                              color: appBgColor,
                            ),
                          )
                        : const SizedBox(width: 1),
                  ]),
                  Stack(children: [
                    GestureDetector(
                      child: Container(
                        height: 60,
                        width: 75,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: yellow),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            Text(
                              "Home",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        car = false;
                        personal = false;
                        education = false;
                        home = true;
                        setState(() {});
                      },
                    ),
                    home
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.check_circle,
                              color: appBgColor,
                            ),
                          )
                        : SizedBox(
                            width: 1,
                          ),
                  ]),
                  Stack(children: [
                    GestureDetector(
                      child: Container(
                        height: 60,
                        width: 75,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.green),
                        child: Column(
                          children: [
                            Icon(
                              Icons.import_contacts,
                              color: Colors.white,
                            ),
                            Text(
                              "Education",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        car = false;
                        personal = false;
                        education = true;
                        home = false;
                        setState(() {});
                      },
                    ),
                    education
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.check_circle,
                              color: appBgColor,
                            ),
                          )
                        : SizedBox(
                            width: 1,
                          ),
                  ]),
                  Stack(children: [
                    GestureDetector(
                      child: Container(
                        height: 60,
                        width: 75,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blueAccent),
                        child: Column(
                          children: [
                            Icon(
                              Icons.car_rental,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Car Loan",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        car = true;
                        personal = false;
                        education = false;
                        home = false;
                        setState(() {});
                      },
                    ),
                    car
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.check_circle,
                              color: appBgColor,
                            ),
                          )
                        : SizedBox(
                            width: 1,
                          ),
                  ]),
                ]),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Enter Loan Amount",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
                textAlign: TextAlign.left,
              ),
            ]),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                        controller: _amountController,
                        focusNode: _amountNode,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: "00",
                          filled: true,
                          fillColor: fillColor,
                          labelStyle: TextStyle(color: fillColor, fontSize: 14),
                        )),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            ),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Down Payment",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
                textAlign: TextAlign.left,
              ),
            ]),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                        controller: _downPaymentController,
                        focusNode: _downPaymentNode,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: "00.00",
                          filled: true,
                          fillColor: fillColor,
                          labelStyle: TextStyle(color: fillColor, fontSize: 14),
                        )),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Tenure",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Interest",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                        /* showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 10,
                              backgroundColor: appBgColor,
                              child:
                              Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    _buildRow( '1 Year'),
                                    _buildRow( '2 Years'),
                                    _buildRow( '3 Years'),
                                    _buildRow('4 Years'),
                                    _buildRow('5 Years'),
                                    _buildRow( '6 Year'),
                                    _buildRow( '7 Years'),
                                    _buildRow( '8 Years'),
                                    _buildRow('9 Years'),
                                    _buildRow('10 Years'),
                                    _buildRow( '11 Year'),
                                    _buildRow( '12 Years'),
                                    _buildRow( '13 Years'),
                                    _buildRow('14 Years'),
                                    _buildRow('15 Years'),
                                    _buildRow( '16 Year'),
                                    _buildRow( '17 Years'),
                                    _buildRow( '18 Years'),
                                    _buildRow('19 Years'),
                                    _buildRow('20 Years')
                                  ],
                                ),
                              ),
                            );
                          },
                        );*/
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedValueYear != 0
                                  ? selectedValueYear.toString() + " Years"
                                  : "Select Years",
                              style: TextStyle(color: darker, fontSize: 14),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(Images.expandArrow),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextField(
                        controller: _rateController,
                        focusNode: _rateNode,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: "00",
                          filled: true,
                          fillColor: fillColor,
                          labelStyle: TextStyle(color: fillColor, fontSize: 14),
                          contentPadding: EdgeInsets.all(10),
                        )),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: IconButton(
                  icon: Image.asset(Images.calculateEMI),
                  iconSize: 50,
                  onPressed: () {
                    if (_amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Amount required",
                            style: TextStyle(color: Colors.white)),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      ));
                    } else if (_rateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Interest Rate required",
                            style: TextStyle(color: Colors.white)),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      ));
                    } else if (selectedValueYear == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Tenure required",
                            style: TextStyle(color: Colors.white)),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      ));
                    } else {
                      double downPayment = 0;
                      if (_downPaymentController.text.isNotEmpty) {
                        downPayment = double.parse(
                            _downPaymentController.text.toString());
                      }
                      double rate =
                          double.parse(_rateController.text.toString());
                      double amount =
                          double.parse(_amountController.text.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoanEMIReportScreen(
                                    time: selectedValueYear,
                                    rate: rate,
                                    princpal: amount,
                                    downPayment: downPayment,
                                  )));
                    }
                  },
                )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ]),
        ));
  }
  /* Widget _buildRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text(name,style: TextStyle(color: Colors.white),),
              Spacer(),
              Radio(value: selectedValueYear,
                 groupValue: groupValueYear, onChanged: (value){
                 selectedValueYear=double.parse(value);
                 print(selectedValueYear);
                 setState(() {
               });
             })
            ],
          ),
        ],
      ),
    );
  }*/

  showAlertDialog(BuildContext context) {
    List<Widget> _list = <Widget>[];
    // set up the list options
    for (int i = 0; i < groupValueYear.length; i++) {
      Widget optionOne = SimpleDialogOption(
        child: Text(
          groupValueYearList[i],
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          selectedValueYear = double.parse(groupValueYear[i]);
          Navigator.of(context).pop();
          setState(() {});
        },
      );
      _list.add(optionOne);
    }

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
        backgroundColor: appBgColor,
        title: const Text(
          'Choose Tenure',
          style: TextStyle(color: Colors.white),
        ),
        children: _list);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
