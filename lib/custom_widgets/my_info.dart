import 'package:flutter/material.dart';
import 'package:flutter_app_to_do_list/custom_widgets/radial_progress.dart';
import 'package:flutter_app_to_do_list/custom_widgets/rounded_image.dart';
import 'package:flutter_app_to_do_list/styleguide/text_style.dart';

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadialProgress(
            width: 4,
            goalCompleted: 0.75,
            child: Hero(
              tag: "assets/images/photo.jpeg",
              child: RoundedImage(
                imagePath: "assets/images/photo.jpeg",
                size: Size.fromWidth(110.0),
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Oğuz KAYA",
                style: whiteNameTextStyle,
              ),
              Text(
                ", 27",
                style: whiteNameTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
        ],
      ),
    );
  }
}
