import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/data/models/player_model.dart';
import 'package:knockout_tournament/features/tournament/presentation/controllers/tournament_controller.dart';
import '../widgets/add_player_dialog.dart';

class TournamentPage2 extends StatelessWidget {
  TournamentPage2({super.key});

  TournamentController controller = Get.put(TournamentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtils.screenHeight! * 0.005,horizontal: ScreenUtils.screenWidth! * 0.007),
          child: Column(
            children: [
              //Top Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff2e2e2e),width: 2,),
                      ),
                      padding: EdgeInsets.symmetric(vertical: ScreenUtils.screenHeight! * 0.006,horizontal: ScreenUtils.screenWidth! * 0.008),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/icons/rdbtick.png",
                                scale: 1.3,
                              ),
                              SizedBox(width: ScreenUtils.screenWidth! * 0.01,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "SHUFFLE THE MATCHES",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtils.screenHeight! * 0.014),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Last shuffled on: ",
                                        style: TextStyle(
                                            color: Color(0xff606060),
                                            fontSize: ScreenUtils.screenHeight! * 0.01),
                                      ),
                                      Text(
                                        controller.lastShuffleDifference(),
                                        style: TextStyle(
                                            color: Color(0xff009011),
                                            fontSize: ScreenUtils.screenHeight! * 0.01),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              // Shuffle Function
                              controller.shuffleAndGeneratePairs();
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Color(0xffc5d1d8), width: 1),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: ScreenUtils.screenHeight! * 0.005,horizontal: ScreenUtils.screenWidth! * 0.01),
                                decoration: BoxDecoration(
                                    color: Color(0xffde2234),
                                    borderRadius: BorderRadius.all(Radius.circular(3))
                                ),
                                child: Text(
                                  "SHUFFLE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtils.screenHeight! * 0.02,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx((){
                    if (controller.currentRound.value == 1){
                      return Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffde2234),
                                border: Border.all(color: Color(0xff2a2626), width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(2))),
                            child: IconButton(
                                onPressed: () {
                                  // Add Player
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
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 50,
                                )),
                          ),
                        ],
                      );
                    }else{
                      return SizedBox(width: 0,);
                    }
                  }),
                ],
              ),
              // Round Information
              Padding(
                padding: EdgeInsets.only(top: 15),
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
              // Wrap ListView.builder with Expanded
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Obx(() {
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

class MatchedPlayers extends StatelessWidget {
  final List<Player> pair;
  final int matchIndex;

  const MatchedPlayers({super.key, required this.matchIndex, required this.pair});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg1.png"), fit: BoxFit.contain)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MATCH $matchIndex", style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500)),
              Text("PENDING", style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.015, fontWeight: FontWeight.w500))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.01),
          width: screenWidth,
          height: screenHeight * 0.1,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: screenWidth * 0.1,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff121212),
                      border: Border.all(color: Color(0xffc1c1c1), width: 1)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.15, top: screenHeight * 0.015),
                        child: Text(pair[0].name.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: screenHeight * 0.028)),
                      ),
                      Spacer(),
                      Container(
                        height: screenHeight * 0.1,
                        width: screenHeight * 0.1,
                        color: Color(0xff2b2b2b),
                        child: Center(
                          child: Text("--".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.03, fontWeight: FontWeight.w700)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.07,
                left: screenHeight * 0.05,
                bottom: screenWidth * 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  // height: screenHeight * 0.05,
                  width: screenWidth * 0.4,
                  padding: EdgeInsets.only(right: screenWidth * 0.07),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg2.png"), fit: BoxFit.contain)
                  ),
                  child: Text(pair[0].gamerTag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: screenHeight * 0.017)),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Container(
                    color: Colors.black,
                    child: Icon(Icons.person_2_rounded, size: screenHeight * 0.1, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (pair.length != 1)
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.01),
            width: screenWidth,
            height: screenHeight * 0.1,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: screenWidth * 0.1,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff121212),
                        border: Border.all(color: Color(0xffc1c1c1), width: 1)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.15, top: screenHeight * 0.015),
                          child: Text(pair[1].name.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: screenHeight * 0.028)),
                        ),
                        Spacer(),
                        Container(
                          height: screenHeight * 0.1,
                          width: screenHeight * 0.1,
                          color: Color(0xff2b2b2b),
                          child: Center(
                            child: Text("--".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.03, fontWeight: FontWeight.w700)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.07,
                  left: screenHeight * 0.05,
                  bottom: screenWidth * 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    // height: screenHeight * 0.05,
                    width: screenWidth * 0.4,
                    padding: EdgeInsets.only(right: screenWidth * 0.07),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg2.png"), fit: BoxFit.contain)
                    ),
                    child: Text(pair[1].gamerTag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: screenHeight * 0.017)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      color: Colors.black,
                      child: Icon(Icons.person_2_rounded, size: screenHeight * 0.1, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),

      ],
    );
  }
}