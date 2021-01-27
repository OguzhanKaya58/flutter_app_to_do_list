import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_to_do_list/custom_widgets/my_info.dart';
import 'package:flutter_app_to_do_list/custom_widgets/opaque_image.dart';
import 'package:flutter_app_to_do_list/custom_widgets/profile_info_big_card.dart';
import 'package:flutter_app_to_do_list/custom_widgets/profile_info_card.dart';
import 'package:flutter_app_to_do_list/main.dart';
import 'package:flutter_app_to_do_list/screens/questions.dart';
import 'package:flutter_app_to_do_list/styleguide/colors.dart';
import 'package:flutter_app_to_do_list/styleguide/text_style.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    OpaqueImage(
                      imageUrl: "assets/images/photo.jpeg",
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_sharp,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    }),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Profilim",
                                    textAlign: TextAlign.left,
                                    style: headingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            MyInfo(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  color: Colors.white,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Questions(),
                                ),
                              );
                            },
                            child: ProfileInfoBigCard(
                              firstText: "1245",
                              secondText: "Çözdüğüm Sorular",
                              icon: Icon(
                                Icons.star,
                                size: 25,
                                color: tealColor,
                              ),
                            ),
                          ),
                          ProfileInfoBigCard(
                            firstText: "21",
                            secondText: "Deneme Sınavlarım",
                            icon: Icon(
                              Icons.favorite,
                              size: 25,
                              color: tealColor,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "320",
                            secondText: "Kalan Sorularım",
                            icon: Image.asset(
                              "assets/icons/location_pin.png",
                              width: 25,
                              color: tealColor,
                            ),
                          ),
                          ProfileInfoBigCard(
                              firstText: "21",
                              secondText: "İtiraz Hakkım",
                              icon: Image.asset(
                                "assets/icons/checklist.png",
                                width: 25,
                                color: tealColor,
                              )),
                        ],
                      ),
                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "782",
                            secondText: "Arkadaşlarım",
                            icon: Icon(
                              Icons.supervised_user_circle,
                              size: 25,
                              color: tealColor,
                            ),
                          ),
                          ProfileInfoBigCard(
                              firstText: "21",
                              secondText: "Öğretmenlerim",
                              icon: Image.asset(
                                "assets/icons/pulse.png",
                                width: 25,
                                color: tealColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: screenHeight * (4 / 9) - 80 / 2,
            left: 16,
            right: 16,
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ProfileInfoCard(
                    firstText: "54%",
                    secondText: "Tamamlandı",
                  ),
                  ProfileInfoCard(
                    hasImage: true,
                    imagePath: "assets/icons/pulse.png",
                  ),
                  ProfileInfoCard(
                    firstText: "132",
                    secondText: "Seviye",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
