import 'package:flutter/material.dart';
import 'package:flutter_app_to_do_list/custom_widgets/two_line_item.dart';
import 'package:flutter_app_to_do_list/styleguide/colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final firstText, secondText, hasImage, imagePath;

  const ProfileInfoCard({Key key, this.firstText, this.secondText, this.hasImage = false, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: hasImage
            ? Center(
          child: Image.asset(
            imagePath,
            color: primaryColor,
            width: 25,
            height: 25,
          ),
        )
            : TwoLineItem(
          firstText: firstText,
          secondText: secondText,
        ),
      ),
    );
  }
}