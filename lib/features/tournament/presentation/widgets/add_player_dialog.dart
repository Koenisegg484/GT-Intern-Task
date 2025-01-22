import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/data/models/player_model.dart';
import 'package:knockout_tournament/generated/assets.dart';

typedef StringCallback = void Function(Player);

class AddPlayerDialog extends StatelessWidget {

  final String oprTitle;
  final String btnTitle;
  final StringCallback onPressed;
  AddPlayerDialog({super.key, required this.oprTitle, required this.btnTitle, required this.onPressed});

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
          width: ScreenUtils.screenWidth!*0.9,
          height: ScreenUtils.screenHeight!*0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.bgImagesPopupBg),
              fit: BoxFit.fill
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ScreenUtils.screenWidth! * 0.58,
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg_images/popup_bg1.png"),
                    alignment: AlignmentDirectional.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      oprTitle,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtils.screenHeight!*0.02,),
              Form(
                child: Column(
                  children: [
                    TextInputField(heading: "Player name", maxlength: 30, ctrl: nameCtrl,),
                    SizedBox(height: 10,),
                    TextInputField(heading: "Player ID", maxlength: 10, ctrl: idCtrl,),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: (){
                  Player newPlayer = Player(name: nameCtrl.text, gamerTag: idCtrl.text, imageUrl: '');
                  onPressed(newPlayer);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom( elevation: 5, shadowColor: Colors.red, padding: EdgeInsets.zero, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0), ), ),
                child: Container(
                  width: ScreenUtils.screenWidth!*0.7,
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
                    child: Text(btnTitle, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
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
  const TextInputField({super.key, required this.ctrl, required this.heading, required this.maxlength});

  final TextEditingController ctrl;
  final String heading;
  final int maxlength;

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: Color(0xff090909),
              child: Text(
                heading,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(color: Color(0xff2e2e2e),height: 1, thickness: 3,),
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
                inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')), ],
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 22),
                decoration: InputDecoration(

                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  counterText: ""
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
