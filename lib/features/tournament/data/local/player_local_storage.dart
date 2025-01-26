import 'package:hive/hive.dart';
import '../models/player_model.dart';

class PlayerLocalStorage {
  static const String boxName = 'players';

  Future<void> addPlayer(Player player) async {
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

  Future<void> editPlayer(String playerId, Player updatedPlayer) async {
    final box = await Hive.openBox<Player>(boxName);
    final playerKey = box.keys.firstWhere((key) => box.get(key)?.gamerTag == playerId, orElse: () => null);
    if (playerKey != null) {
      await box.put(playerKey, updatedPlayer);
    }
  }

  Future<void> deletePlayer(String playerId) async {
    final box = await Hive.openBox<Player>(boxName);
    final playerKey = box.keys.firstWhere((key) => box.get(key)?.gamerTag == playerId, orElse: () => null);
    if (playerKey != null) {
      await box.delete(playerKey);
    }
  }
}
