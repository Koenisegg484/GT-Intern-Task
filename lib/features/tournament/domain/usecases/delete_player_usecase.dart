import '../../data/local/player_local_storage.dart';

class DeletePlayerUseCase {
  final PlayerLocalStorage playerLocalStorage;

  DeletePlayerUseCase(this.playerLocalStorage);

  Future<void> execute(String playerId) async {
    await playerLocalStorage.deletePlayer(playerId);
  }
}
