import 'package:hive/hive.dart';

import '../models/player_model.dart';


class PlayerLocalStorage {
  static const String boxName = 'players';

  Future<void> addPlayer(Player player) async {
    print("Added player: ${player.toString()}");
    final box = await Hive.openBox<Player>(boxName);
    await box.add(player);
  }

  Future<List<Player>> getPlayers() async {
    final box = await Hive.openBox<Player>(boxName);
    return box.values.toList();
  }

  Future<void> clearPlayers() async {
    final box = await Hive.openBox<Player>(boxName);
    await box.clear();
  }
}
