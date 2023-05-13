
import '../utils/images.dart';

class SliderModel{
  String image;

// images given
  SliderModel({ required this.image});

// setter for image
  void setImage(String getImage){
    image = getImage;
  }

// getter for image
  String getImage(){
    return image;
  }
}
List<SliderModel> getSlides(){
  List<SliderModel> slides = <SliderModel>[];

// 1
  SliderModel sliderModel1 = SliderModel(image: Images.onboard1);
  slides.add(sliderModel1);
// 2
  SliderModel sliderModel2 = SliderModel(image: Images.onboard2);
  slides.add(sliderModel2);

// 3
  SliderModel sliderModel3 = SliderModel(image: Images.onboard3);
  slides.add(sliderModel3);

  return slides;
}

