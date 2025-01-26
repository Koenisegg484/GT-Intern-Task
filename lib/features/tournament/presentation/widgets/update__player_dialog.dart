import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/data/models/player_model.dart';
import 'package:knockout_tournament/features/tournament/presentation/controllers/tournament_controller.dart';
import 'package:knockout_tournament/generated/assets.dart';

class UpdatePlayerDialog extends StatelessWidget {
  final String oprTitle;
  final String btnTitle;
  final Player player;

  UpdatePlayerDialog(
      {super.key,
      required this.oprTitle,
      required this.btnTitle,
      required this.player});

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenUtils.screenHeight!;
    final screenWidth = ScreenUtils.screenWidth!;

    nameCtrl.text = player.name;
    idCtrl.text = player.gamerTag;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              top: 0,
              bottom: screenWidth * 0.05),
          width: screenWidth * 0.9,
          // height: screenHeight * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.bgImagesPopupBg), fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: Stack(
                  children: [
                    Positioned(
                      top: screenWidth * 0.02,
                      left: 0,
                      right: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          oprTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.025),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenWidth * 0.02,
                      right: screenWidth * 0.015,
                      child: IconButton(
                        onPressed: () {
                          Get.find<TournamentController>().deletePlayer(player.gamerTag);
                        },
                        icon: Container(
                            alignment: Alignment.center,
                            height: screenHeight * 0.03,
                            width: screenHeight * 0.03,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                color: Color(0xff273133),
                                border: Border.all(
                                    color: Color(0xff4a5c60), width: 1),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: screenHeight * 0.025,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Form(
                child: Column(
                  children: [
                    TextInputField(
                        heading: "Player name", maxlength: 30, ctrl: nameCtrl),
                    SizedBox(height: screenHeight * 0.01),
                    TextInputField(
                        heading: "Player ID", maxlength: 10, ctrl: idCtrl),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  Player newPlayer = Player(name: nameCtrl.text, gamerTag: idCtrl.text);
                  newPlayer.imageUrl = player.imageUrl;
                  Get.find<TournamentController>().editPlayer(player.gamerTag, newPlayer);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shadowColor: Colors.red,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Container(
                  width: screenWidth * 0.7,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xffc5d1d8), width: 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffde2234),
                      border: Border.all(color: Color(0xff090909), width: 3),
                    ),
                    child: Text(btnTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key,
      required this.ctrl,
      required this.heading,
      required this.maxlength});

  final TextEditingController ctrl;
  final String heading;
  final int maxlength;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff2e2e2e),
            width: 3,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01, horizontal: 12),
              color: Color(0xff090909),
              child: Text(
                heading,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.02,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(color: Color(0xff2e2e2e), height: 1, thickness: 3),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff202020),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xff2e2e2e), width: 1),
                ),
              ),
              child: TextFormField(
                controller: ctrl,
                maxLength: maxlength,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]'))
                ],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: screenHeight * 0.02),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: screenHeight * 0.005),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    counterText: ""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
