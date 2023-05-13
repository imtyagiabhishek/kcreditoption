import 'package:flutter/material.dart';
import 'package:kreditoption/model/menu_model.dart';

import '../theme/color.dart';
import '../utils/app_constants.dart';
import '../utils/images.dart';

class kMenuItem extends StatelessWidget {
  kMenuItem(
      {Key? key,
      this.image,
      required this.data,
      this.description,
      required this.onTap})
      : super(key: key);
  final MenuModel data;
  final image;
  final description;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(
              data.image!,
              height: 120,
              width: 160,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Text(
                data.name! + " >>",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
