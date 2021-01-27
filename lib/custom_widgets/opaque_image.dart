import 'package:flutter/material.dart';
import 'package:flutter_app_to_do_list/styleguide/colors.dart';

class OpaqueImage extends StatelessWidget {
  final imageUrl;

  const OpaqueImage({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imageUrl,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(
          color: Colors.teal.withOpacity(0.60),
        ),
      ],
    );
  }
}
