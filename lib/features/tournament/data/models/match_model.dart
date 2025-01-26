import 'package:hive/hive.dart';
import 'package:knockout_tournament/features/tournament/data/models/player_model.dart';
import 'package:knockout_tournament/features/tournament/domain/usecases/shuffle_players_usecase.dart';

part 'match_model.g.dart';

@HiveType(typeId: 1)
class TournamentMatch {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String bannerUrl;

  @HiveField(3)
  List<String> timeStampHistory;

  @HiveField(4)
  List<Player> participantingPlayers;

  @HiveField(5)
  List<List<Player>> matchedPairs = <List<Player>>[];

  @override
  String toString() {
    return "Match \nid: $id\ntitle: $title\nlast timestamp: ${timeStampHistory[timeStampHistory.length - 1]}\nParticipants:$participantingPlayers\nmatched pairs: $matchedPairs";
  }

  TournamentMatch({
    required this.id,
    required this.title,
    required this.timeStampHistory,
    required this.participantingPlayers,
    this.bannerUrl = ""
  }) {
    ShufflePlayersUsecase shufflePlayersUsecase = ShufflePlayersUsecase();
    matchedPairs = shufflePlayersUsecase.call(participantingPlayers);
    timeStampHistory.add(DateTime.now().toString());
    print("$title Tournament was shuffled Successfully");
  }

  get key => null;

  // Method to add a player
  void addPlayer(Player player) {
    participantingPlayers.add(player);
    _updateMatchedPairs();
    _addTimestamp();
  }

  // Method to remove a player
  void removePlayer(Player player) {
    participantingPlayers.remove(player);
    _updateMatchedPairs();
    _addTimestamp();
  }

  // Private method to update matched pairs
  void _updateMatchedPairs() {
    ShufflePlayersUsecase shufflePlayersUsecase = ShufflePlayersUsecase();
    matchedPairs = shufflePlayersUsecase.call(participantingPlayers);
    print("Matched pairs updated for $title");
  }

  // Method to update title
  void updateTitle(String newTitle) {
    title = newTitle;
    _addTimestamp();
  }

  // Method to update banner URL
  void updateBannerUrl(String newUrl) {
    bannerUrl = newUrl;
    print("$title's banner has been updated");
  }

  // Private method to add a timestamp
  void _addTimestamp() {
    timeStampHistory.add(DateTime.now().toString());
  }


}
