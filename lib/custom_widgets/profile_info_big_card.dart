import 'package:flutter/material.dart';
import 'package:flutter_app_to_do_list/styleguide/text_style.dart';

class ProfileInfoBigCard extends StatelessWidget {
  final String firstText, secondText;
  final Widget icon;

  const ProfileInfoBigCard(
      {Key key,
      @required this.firstText,
      @required this.secondText,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 8.0,
          bottom: 8.0,
          right: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: icon,
              alignment: Alignment.topRight,
            ),
            Text(
              firstText,
              style: titleStyle,
            ),
            Text(
              secondText,
              style: subTitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
