import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/presentation/controllers/tournament_controller.dart';
import '../widgets/add_player_dialog.dart';
import '../widgets/matched_pairs_widget.dart';

class TournamentPage2 extends StatelessWidget {
  TournamentPage2({super.key});

  TournamentController controller = Get.put(TournamentController());

  @override
  Widget build(BuildContext context) {
    // controller.shuffleAndGeneratePairs();
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtils.screenHeight! * 0.005,horizontal: ScreenUtils.screenWidth! * 0.02),
          child: Column(
            children: [
              //Top Bar to display the last shuffle time, the shuffle button and the add player button
              Obx((){
                if(controller.currentRound.value == 1){
                  return  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff2e2e2e), width: 2),
                          ),
                          padding: EdgeInsets.symmetric(vertical: ScreenUtils.screenHeight! * 0.006, horizontal: ScreenUtils.screenWidth! * 0.02),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image Icon Red Tick
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.black),
                                        BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: -5.0,
                                          blurRadius: 20.0,
                                        ),
                                      ],
                                    ),
                                    child: Image.asset("assets/icons/rdbtick.png",scale: 1.3,),
                                  ),
                                  SizedBox(width: ScreenUtils.screenWidth! * 0.01),
                                  // Top Bar title
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "SHUFFLE THE MATCHES",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                            ScreenUtils.screenHeight! * 0.01),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Last shuffled on: ",
                                            style: TextStyle(
                                                color: Color(0xff606060),
                                                fontSize:
                                                ScreenUtils.screenHeight! *
                                                    0.007),
                                          ),
                                          Text(
                                            controller.lastShuffleDifference(),
                                            style: TextStyle(
                                                color: Color(0xff009011),
                                                fontSize:
                                                ScreenUtils.screenHeight! *
                                                    0.007),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              // The Shuffle Button
                              GestureDetector(
                                onTap: () {
                                  // Shuffle Function
                                  controller.shuffleAndGeneratePairs();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Color(0xffc5d1d8), width: 1),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                        ScreenUtils.screenHeight! * 0.005,
                                        horizontal:
                                        ScreenUtils.screenWidth! * 0.03),
                                    decoration: BoxDecoration(
                                        color: Color(0xffd81e33),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(3))),
                                    child: Text(
                                      "SHUFFLE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          ScreenUtils.screenHeight! * 0.01,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtils.screenWidth!*0.015),
                      // The Add Player Button
                      InkWell(
                        onTap: () {
                          // Add Player dialog pop up
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddPlayerDialog(
                                oprTitle: "ADD PLAYER",
                                btnTitle: "ADD",
                                onPressed: (player) {
                                  controller.addPlayer(player);
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          // height: ScreenUtils.screenHeight!*0.053,
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtils.screenHeight! * 0.006,
                              horizontal: ScreenUtils.screenWidth! * 0.008),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xffd31933),
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: ScreenUtils.screenHeight!*0.04,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox(height: 0,);
              }),
              // Round Information
              Padding(
                padding: EdgeInsets.only(top: ScreenUtils.screenHeight!*0.02, bottom: ScreenUtils.screenHeight!*0.02),
                child: Center(
                  child: Obx(() {
                    return Text(
                      controller.roundLabel,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtils.screenHeight! * 0.02,
                          fontWeight: FontWeight.w500),
                    );
                  }),
                ),
              ),
              // List of matches of pairs of players
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtils.screenWidth!*0.025),
                  child: Obx(() {
                    // TODO: Look into why  matched pairs are not initialising in the start
                    if (controller.matchedPairs.value.isEmpty) {
                      return Center(child: Text("No matches found"));
                    }
                    return ListView.builder(
                      itemCount: controller.matchedPairs.value.length,
                      itemBuilder: (context, index) {
                        return MatchedPlayers(
                          matchIndex: index + 1,
                          pair: controller.matchedPairs.value[index],
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('FAB Pressed');
          controller.progressToNextRound();
        },
        label: Text("Next Round"),
        icon: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
