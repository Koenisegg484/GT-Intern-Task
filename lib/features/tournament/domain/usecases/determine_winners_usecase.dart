import '../../data/models/player_model.dart';

class DetermineWinnersUsecase {
  List<Player> call(List<List<Player>> pairs) {
    final List<Player> winners = [];

    for (final pair in pairs) {
      if (pair.length == 2) {
        // Randomly determining a winner for now
        pair[0].isWinner = true;
        winners.add(pair[0]);
      } else {
        winners.add(pair[0]);
      }
    }
    return winners;
  }
}
