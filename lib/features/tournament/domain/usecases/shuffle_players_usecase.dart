import 'dart:math';
import '../../data/models/player_model.dart';

class ShufflePlayersUsecase {
  List<List<Player>> call(List<Player> players) {
    final shuffledPlayers = List<Player>.from(players);
    shuffledPlayers.shuffle(Random());

    // Pair the shuffled players
    final List<List<Player>> pairs = [];
    for (int i = 0; i < shuffledPlayers.length; i += 2) {
      if (i + 1 < shuffledPlayers.length) {
        pairs.add([shuffledPlayers[i], shuffledPlayers[i + 1]]);
      } else {
        pairs.add([shuffledPlayers[i]]);
      }
    }
    return pairs;
  }
}


// class ShufflePlayersUsecase {
//   List<List<Player>> call(List<Player> players) {
//     players.shuffle();
//     List<List<Player>> pairs = [];
//     for (int i = 0; i < players.length; i += 2) {
//       if (i + 1 < players.length) {
//         pairs.add([players[i], players[i + 1]]);
//       }
//     }
//     return pairs;
//   }
// }
