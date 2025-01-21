import '../../data/local/player_local_storage.dart';
import '../../data/models/player_model.dart';

class AddPlayerUseCase {
  final PlayerLocalStorage playerLocalStorage;

  AddPlayerUseCase(this.playerLocalStorage);

  Future<void> execute(Player player) async {
    await playerLocalStorage.addPlayer(player);
  }
}
