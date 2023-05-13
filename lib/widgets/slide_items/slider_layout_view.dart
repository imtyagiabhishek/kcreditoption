import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kreditoption/pages/login_screen.dart';
import 'package:kreditoption/widgets/slide_items/slide_dots.dart';

import '../../controller/auth_controller.dart';
import '../../model/slider.dart';
import '../../pages/dashboard_screen.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import 'slide_item.dart';

class SliderLayoutView extends StatefulWidget {
  const SliderLayoutView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  String _string = AppConstants.NEXT;

  int pageno = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged2(int index) {
    print(index++);
    _currentPage = index;
    pageno = index;
    if (pageno <= 2) {
      /* if (_currentPage == 2) {
        _string = "Submit";
      } else {*/
      _pageController.jumpToPage(index);
      //  }
      setState(() {});
    } else {
      Get.find<AuthController>().setFirst();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  _skip() {
    Get.find<AuthController>().setFirst();
    //  Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (_) => DashboardScreen()));
  }

  _onPageChanged(int index) {
    pageno = index;
    setState(() {
      _currentPage = index;
      if (_currentPage == 2) {
        _string = "Submit";
      }
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
        child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: sliderArrayList.length,
                  itemBuilder: (ctx, i) => SlideItem(i),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    /*  Expanded(
                        child: IconButton(
                          icon: Image.asset(Images.continueImage),
                          iconSize: 400,
                          onPressed: () {
                            _onPageChanged2(pageno);
                          },
                        )
                    ),*/

                    Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          icon: Image.asset(Images.continueImage),
                          iconSize: 300,
                          onPressed: () {
                            _onPageChanged2(pageno);
                          },
                        )),
                    /*  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                        child: InkWell(child: Text(
                         _string,
                          style: TextStyle(
                            fontFamily: AppConstants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                          onTap: (){
                            _onPageChanged2(pageno);
                          },
                        )
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child:InkWell(child: Text(
                          AppConstants.SKIP,
                          style: TextStyle(
                            fontFamily: AppConstants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                        )
                      ),
                    ),*/
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}
