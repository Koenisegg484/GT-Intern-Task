import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/presentation/controllers/tournament_controller.dart';
import 'package:knockout_tournament/features/tournament/presentation/widgets/update__player_dialog.dart';
import '../../data/models/player_model.dart';
import 'custom_profile_image.dart';

class MatchedPlayers extends StatelessWidget {
  final List<Player> pair;
  final int matchIndex;
  TournamentController controller = Get.find();

  MatchedPlayers({super.key, required this.matchIndex, required this.pair});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenHeight = ScreenUtils.screenHeight!;
    final screenWidth = ScreenUtils.screenWidth!;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth*0.25,
                  padding: EdgeInsets.only(left: screenWidth * 0.01, top: screenWidth * 0.005, bottom: screenWidth * 0.005),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg3.png"), fit: BoxFit.cover),),
                  child: Text("MATCH $matchIndex",style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.012, fontWeight: FontWeight.w400),),
                ),
                Text("PENDING",style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.014, fontWeight: FontWeight.w400),),
              ],
            ),
            Divider( color: Color(0xffd31933), height: 0, thickness: 1),
          ],
        ),
    GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return UpdatePlayerDialog(
                    oprTitle: "UPDATE PLAYER",
                    btnTitle: "UPDATE",
                    player: pair[0],
                  );
                }
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.005),
            width: screenWidth,
            height: screenHeight * 0.06,
            child: Stack(
              children: [
                // Row for displaying player details
                Positioned(
                  top: 0,
                  left: screenHeight * 0.0325,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container for name
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: screenHeight*0.052, top: screenHeight * 0.01),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x832a2a2a),
                            border: Border.symmetric(horizontal: BorderSide(color: Color(0xffc1c1c1), width: 1),),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: screenWidth*0.003,
                                color: Color(0xff2a2a2a).withAlpha(20),
                              ),
                              BoxShadow(
                                offset: Offset(1, 2),
                                blurRadius: screenWidth*0.07,
                                spreadRadius: 1,
                                color: Color(0xFF656464).withAlpha(90),
                                inset: true,
                              ),
                            ],
                          ),
                          child: Text(pair[0].name.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: screenHeight * 0.02)),
                        ),
                      ),
                      // Container for scores
                      Container(
                        height: screenHeight * 0.065,
                        width: screenHeight * 0.065,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: (screenWidth + screenHeight) / 30,
                              color: Color(0xFF1F1F1F).withAlpha(10),
                            ),
                            BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: (screenWidth + screenHeight) / 30,
                              spreadRadius: 1,
                              // color: Color(0xffd7d7d7),
                              color: pair[0].isWinner? Color(0xff3fb118) : Color(0xffec0000),
                              inset: true,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text("21".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.025, fontWeight: FontWeight.w700)),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: screenHeight * 0.0325,
                  bottom: screenWidth * 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: screenWidth * 0.25,
                    padding: EdgeInsets.only(left: screenWidth * 0.053,right: screenWidth * 0.03, top: screenHeight * 0.001, bottom: screenHeight * 0.001),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg2.png"), fit: BoxFit.cover)
                    ),
                    child: Text(pair[0].gamerTag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: screenHeight * 0.011), maxLines: 1,),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: IndividualFrame(height: screenHeight * 0.065, width: screenWidth * 0.17, imageUrl: pair[0].imageUrl),
                ),
              ],
            ),
          ),
        ),
        if (pair.length != 1)
          GestureDetector(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UpdatePlayerDialog(
                      oprTitle: "UPDATE PLAYER",
                      btnTitle: "UPDATE",
                      player: pair[1],
                    );
                  }
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.005),
              width: screenWidth,
              height: screenHeight * 0.06,
              child: Stack(
                children: [
                  // Row for displaying player details
                  Positioned(
                    top: 0,
                    left: screenHeight * 0.0325,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container for name
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: screenHeight*0.052, top: screenHeight * 0.01),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0x832a2a2a),
                              border: Border.symmetric(horizontal: BorderSide(color: Color(0xffc1c1c1), width: 1),),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: screenWidth*0.003,
                                  color: Color(0xff2a2a2a).withAlpha(20),
                                ),
                                BoxShadow(
                                  offset: Offset(1, 2),
                                  blurRadius: screenWidth*0.07,
                                  spreadRadius: 1,
                                  color: Color(0xFF656464).withAlpha(90),
                                  inset: true,
                                ),
                              ],
                            ),
                            child: Text(pair[1].name.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: screenHeight * 0.02)),
                          ),
                        ),
                        // Container for scores
                        Container(
                          height: screenHeight * 0.065,
                          width: screenHeight * 0.065,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: (screenWidth + screenHeight) / 30,
                                color: Color(0xFF1F1F1F).withAlpha(10),
                              ),
                              BoxShadow(
                                offset: Offset(1, 2),
                                blurRadius: (screenWidth + screenHeight) / 30,
                                spreadRadius: 1,
                                // color: Color(0xffd7d7d7),
                                color: pair[1].isWinner? Color(0xff3fb118) : Color(0xffec0000),
                                inset: true,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text("21".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.025, fontWeight: FontWeight.w700)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: screenHeight * 0.0325,
                    bottom: screenWidth * 0,
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: screenWidth * 0.25,
                      padding: EdgeInsets.only(left: screenWidth * 0.053,right: screenWidth * 0.03, top: screenHeight * 0.001, bottom: screenHeight * 0.001),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg2.png"), fit: BoxFit.cover)
                      ),
                      child: Text(pair[1].gamerTag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: screenHeight * 0.011), maxLines: 1,),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: IndividualFrame(height: screenHeight * 0.065, width: screenWidth * 0.17, imageUrl: pair[1].imageUrl),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: screenHeight * 0.04),
      ],
    );
  }
}