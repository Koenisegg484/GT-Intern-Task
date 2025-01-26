import '../../data/local/player_local_storage.dart';
import '../../data/models/player_model.dart';

class EditPlayerUseCase {
  final PlayerLocalStorage playerLocalStorage;

  EditPlayerUseCase(this.playerLocalStorage);

  Future<void> execute(String playerId, Player updatedPlayer) async {
    await playerLocalStorage.editPlayer(playerId, updatedPlayer);
  }
}
