import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/data/models/player_model.dart';
import 'package:knockout_tournament/features/tournament/presentation/controllers/tournament_controller.dart';
import '../widgets/add_player_dialog.dart';

class TournamentPage2 extends StatelessWidget {
  TournamentPage2({super.key});

  TournamentController controller = TournamentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtils.screenHeight! * 0.005,
              horizontal: ScreenUtils.screenWidth! * 0.007),
          child: Column(
            children: [
              //Top Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff2e2e2e),
                          width: 2,
                        ),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "SHUFFLE THE MATCHES",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
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
                                            fontSize: 16),
                                      ),
                                      Text(
                                        controller.lastShuffleDifference(),
                                        style: TextStyle(
                                            color: Color(0xff009011),
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              // Shuffle Function
                              controller.shuffleAndGeneratePairs();
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
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Color(0xffc5d1d8), width: 1),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xffde2234),
                                    border: Border.all(
                                        color: Color(0xff090909), width: 3),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                                child: Text(
                                  "SHUFFLE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
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
                  if (controller.isFirstRound)
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffde2234),
                              border: Border.all(color: Color(0xff2a2626), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(2))),
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
                    ),
                ],
              ),
              // Round Information
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Obx(() {
                    return Text(
                      controller.roundLabel,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
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
                    return ListView.builder(
                      itemCount: controller.matchedPairs.length,
                      itemBuilder: (context, index) {
                        return MatchedPlayers(
                            matchIndex: index + 1,
                            pair: controller.matchedPairs[index]);
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff000000),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: ScreenUtils.screenHeight!*0.005, horizontal: ScreenUtils.screenWidth!*0.007),
//           child: Column(
//             children: [
//               //Top Bar
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xff2e2e2e),
//                           width: 2,
//                         ),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/icons/rdbtick.png", scale: 1.3,),
//                               SizedBox(width: 8,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("SHUFFLE THE MATCHES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text("Last shuffled on: ", style: TextStyle(color: Color(0xff606060), fontSize: 16),),
//                                       Text(controller.lastShuffleDifference(), style: TextStyle(color: Color(0xff009011), fontSize: 16),),
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           Spacer(),
//                           ElevatedButton(
//                             onPressed: (){
//                             //   Shuffle Function
//                               controller.shuffleAndGeneratePairs();
//                             },
//                             style: ElevatedButton.styleFrom(
//                               elevation: 5,
//                               shadowColor: Colors.red,
//                               padding: EdgeInsets.zero,
//                               shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0), ), ),
//                             child: Container(
//                               padding: EdgeInsets.all(1),
//                               decoration: BoxDecoration(
//                                 color: Colors.transparent,
//                                 border: Border.all(color: Color(0xffc5d1d8), width: 1),
//                               ),
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xffde2234),
//                                   border: Border.all(color: Color(0xff090909), width: 3),
//                                   borderRadius: BorderRadius.all(Radius.circular(2))
//                                 ),
//                                 child: Text("SHUFFLE", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   if(controller.isFirstRound) Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Color(0xffde2234),
//                               border: Border.all(color: Color(0xff2a2626), width: 1),
//                               borderRadius: BorderRadius.all(Radius.circular(2))
//                           ),
//                           child: IconButton(onPressed: (){
//                             //   Add Player
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AddPlayerDialog(oprTitle: "ADD PLAYER", btnTitle: "ADD", onPressed: (player) {
//                                   controller.addPlayer(player);
//                                 },);
//                               },
//                             );
//                           },
//                               icon: Icon(Icons.add_rounded, color: Colors.white, size: 50,)),
//                         ),
//                       ],
//                     ),
//
//                 ],
//               ),
//             //   Round Information
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 child: Center(
//                   child: Obx((){
//                     return Text(controller.roundLabel, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),);
//                   }),
//                 ),
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Obx((){
//                   return ListView.builder(
//                     itemCount: controller.matchedPairs.length,
//                     itemBuilder: (context, index){
//                       return MatchedPlayers(matchIndex: index+1, pair: controller.matchedPairs[index]);
//                     }
//                   );
//                 }),
//               )
//             ],
//           ),
//         ),
//       )
//     );
//   }
}


class MatchedPlayers extends StatelessWidget {
  final List<Player> pair;
  final int matchIndex;

  const MatchedPlayers({super.key, required this.matchIndex, required this.pair});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg1.png"), fit: BoxFit.cover)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MATCH $matchIndex", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
              Text("PENDING", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          width: ScreenUtils.screenWidth,
          height: ScreenUtils.screenHeight!*0.07,
          child: Stack(
            children: [
              Positioned(
                top: 0,left: 40,right: 0,bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff121212),
                      border: Border.all(color: Color(0xffc1c1c1), width: 1)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 55, top: 15),
                        child: Text(pair[0].name.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
                      ),
                      Spacer(),
                      Container(
                        height: ScreenUtils.screenHeight!*0.07,
                        width: ScreenUtils.screenHeight!*0.07,
                        color: Color(0xff2b2b2b),
                        child: Center(
                          child: Text("--".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtils.screenHeight!*0.04,
                left: ScreenUtils.screenHeight!*0.03,
                child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    width: 160,
                    padding: EdgeInsets.only(top: 15, right:15, bottom: 15),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg2.png"), fit: BoxFit.cover)
                    ),
                    child: Text(pair[0].gamerTag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),)
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
                      child: Icon(Icons.person_2_rounded, size: ScreenUtils.screenHeight!*0.07,color: Colors.grey,)),
                ),
              ),
            ],
          ),
        ),
        if(pair.length != 1)Container(
          margin: EdgeInsets.only(top: 12),
          width: ScreenUtils.screenWidth,
          height: ScreenUtils.screenHeight!*0.07,
          child: Stack(
            children: [
              Positioned(
                top: 0,left: 40,right: 0,bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff121212),
                    border: Border.all(color: Color(0xffc1c1c1), width: 1)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 55, top: 15),
                        child: Text(pair[1].name.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
                      ),
                      Spacer(),
                      Container(
                        height: ScreenUtils.screenHeight!*0.07,
                        width: ScreenUtils.screenHeight!*0.07,
                        color: Color(0xff2b2b2b),
                        child: Center(
                          child: Text("--".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtils.screenHeight!*0.04,
                left: ScreenUtils.screenHeight!*0.03,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  width: 160,
                  padding: EdgeInsets.only(top: 15, right:15, bottom: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/bg_images/trnmtbg2.png"), fit: BoxFit.cover)
                    ),
                    child: Text(pair[1].gamerTag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),)
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
                    child: Icon(Icons.person_2_rounded, size: ScreenUtils.screenHeight!*0.07,color: Colors.grey,)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
