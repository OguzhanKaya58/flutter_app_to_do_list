import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_to_do_list/custom_widgets/narrow_app_bar.dart';
import 'package:flutter_app_to_do_list/styleguide/colors.dart';
import 'package:flutter_app_to_do_list/styleguide/text_style.dart';

class Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NarrowAppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        trailing: Text(
          "Seç",
          style: actionMenuStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Sorular",
              style: headingTextStyle.copyWith(color: Colors.black),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Ara",
                    hintStyle: subTitleStyle.copyWith(color: hintTextColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  "Favori Sorular",
                  style: titleStyle.copyWith(color: Colors.black),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "5",
                      style: whiteSubHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "1h",
                  style: subTitleStyle.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: ListTile(
                    title: Text(
                      "Oğuz",
                      style: titleStyle,
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/location_pin.png",
                          width: 15.0,
                          height: 15.0,
                          color: Colors.black,
                        ),
                        Text(
                          " Soru",
                          style: whiteNameTextStyle.copyWith(
                              color: Colors.black, fontSize: 14.0),
                        ),
                      ],
                    ),
                    leading: ClipOval(
                      child: Image.asset(
                        "assets/images/photo.jpeg",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "ONLINE",
                                  style: whiteSubHeadingTextStyle.copyWith(
                                      color: Colors.green, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              Icons.star,
                              color: blueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
