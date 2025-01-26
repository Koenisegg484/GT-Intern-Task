import 'package:get/get.dart';
import 'package:knockout_tournament/features/tournament/data/local/player_local_storage.dart';
import 'package:knockout_tournament/features/tournament/data/models/player_model.dart';
import 'package:knockout_tournament/features/tournament/domain/usecases/add_player_usecase.dart';
import 'package:knockout_tournament/features/tournament/domain/usecases/delete_player_usecase.dart';
import 'package:knockout_tournament/features/tournament/domain/usecases/determine_winners_usecase.dart';
import 'package:knockout_tournament/features/tournament/domain/usecases/edit_player_usecase.dart';
import 'package:knockout_tournament/features/tournament/domain/usecases/shuffle_players_usecase.dart';

class TournamentController extends GetxController{

  final ShufflePlayersUsecase _shufflePlayersUsecase = ShufflePlayersUsecase();
  final DetermineWinnersUsecase _determineWinnersUsecase = DetermineWinnersUsecase();
  final PlayerLocalStorage _playerLocalStorage = PlayerLocalStorage();
  late final AddPlayerUseCase _addPlayerUseCase;
  late final EditPlayerUseCase _editPlayerUseCase;
  late final DeletePlayerUseCase _deletePlayerUseCase;

  RxList<Player> players = <Player>[].obs;
  RxList<List<Player>> matchedPairs = <List<Player>>[].obs;
  RxInt currentRound = 1.obs;
  RxList<String> shuffleHistory = <String>[].obs;

  bool get isFirstRound => currentRound.value == 1;

  @override
  void onInit() {
    super.onInit();
    _editPlayerUseCase = EditPlayerUseCase(_playerLocalStorage);
    _deletePlayerUseCase = DeletePlayerUseCase(_playerLocalStorage);
    _addPlayerUseCase = AddPlayerUseCase(_playerLocalStorage);
    _initialisePlayers();
  }

  Future<void> _initialisePlayers() async {
    players.value = await _playerLocalStorage.getPlayers();
    shuffleAndGeneratePairs();
  }

  void shuffleAndGeneratePairs() {
    final timestamp = DateTime.now().toString();
    shuffleHistory.add(timestamp);
    matchedPairs.value = _shufflePlayersUsecase(players.value);
  }

  Future<void> editPlayer(String playerId, Player updatedPlayer) async {
    await _editPlayerUseCase.execute(playerId, updatedPlayer);
  }

  Future<void> deletePlayer(String playerId) async {
    await _deletePlayerUseCase.execute(playerId);
    players.value = await _playerLocalStorage.getPlayers();
    shuffleAndGeneratePairs();
  }

  void progressToNextRound(){
    if(matchedPairs.value.length == 1){
      Get.snackbar("End of Tournament", "The tournament has ended");
      return;
    }
    players.value = _determineWinnersUsecase(matchedPairs.value);
    currentRound.value++;

    if(players.length > 1){
      shuffleAndGeneratePairs();
    }
  }

  String lastShuffleDifference() {
    if (shuffleHistory.isEmpty) {
      return "--";
    }

    try {
      DateTime tmstp = DateTime.parse(shuffleHistory.last);
      final diff = DateTime.now().difference(tmstp);

      if (diff.inMinutes < 60) {
        return "${diff.inMinutes}m ago";
      } else {
        final hours = diff.inHours;
        final minutes = diff.inMinutes % 60;
        return minutes == 0 ? "${hours}h ago" : "${hours}h ${minutes}m ago";
      }
    } catch (e) {
      return "Error calculating shuffle difference: $e";
    }
  }


  String get roundLabel{
    switch (players.length){
      case 2:
        return "Finals";
      case 3:
      case 4:
        return "Semi-Finals";
      default:
        return "Round $currentRound";
    }
  }

  Future<void> addPlayer(Player player) async {
    await _addPlayerUseCase.execute(player);
    players.value = await _playerLocalStorage.getPlayers();
    shuffleAndGeneratePairs();
  }

  void selectWinner(List<Player> pair, Player winner){
    for(var player in pair){
      player.isWinner = false;
    }
    winner.isWinner = true;
  }

}