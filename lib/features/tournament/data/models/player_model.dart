import 'package:hive/hive.dart';

import '../../../../core/utils/constants.dart';

part 'player_model.g.dart';

@HiveType(typeId: 0)
class Player {
  @HiveField(0)
  String name;

  @HiveField(1)
  String gamerTag;

  @HiveField(2)
  String imageUrl='';

  @HiveField(3)
  bool isWinner;

  @override
  String toString() {
    return 'Player{name: $name, gamerTag: $gamerTag, imageUrl: $imageUrl, isWinner: $isWinner}';
  }

  Player({
    required this.name,
    required this.gamerTag,
    this.isWinner = false,
  }){
    imageUrl = "assets/profiles/${getRandomProfilePath()}";
  }
}
