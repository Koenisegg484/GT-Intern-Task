import 'package:hive/hive.dart';

part 'player_model.g.dart';

@HiveType(typeId: 0)
class Player {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String gamerTag;

  @HiveField(2)
  final String imageUrl;

  bool isWinner;

  Player({
    required this.name,
    required this.gamerTag,
    required this.imageUrl,
    this.isWinner = false
  });
}
