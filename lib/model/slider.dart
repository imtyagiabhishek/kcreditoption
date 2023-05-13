import 'package:flutter/cupertino.dart';

import '../utils/app_constants.dart';

class Slider {
  final String? sliderImageUrl;
  final String? sliderHeading;
  final String? sliderSubHeading;

  Slider(
      {@required this.sliderImageUrl,
      @required this.sliderHeading,
      @required this.sliderSubHeading});
}

final sliderArrayList = [
    Slider(
        sliderImageUrl: 'assets/image/slider_1.png',
        sliderHeading: AppConstants.SLIDER_HEADING_1,
        sliderSubHeading: AppConstants.SLIDER_DESC_1),
    Slider(
        sliderImageUrl: 'assets/image/slider_2.png',
        sliderHeading: AppConstants.SLIDER_HEADING_2,
        sliderSubHeading: AppConstants.SLIDER_DESC_2),
    Slider(
        sliderImageUrl: 'assets/image/slider_3.png',
        sliderHeading: AppConstants.SLIDER_HEADING_3,
        sliderSubHeading: AppConstants.SLIDER_DESC_3),
  ];
