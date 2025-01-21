import 'package:get/get.dart';

import 'features/tournament/data/local/player_local_storage.dart';
import 'features/tournament/domain/usecases/add_player_usecase.dart';

void setupDependencyInjection() {
  Get.lazyPut<PlayerLocalStorage>(() => PlayerLocalStorage());
  Get.lazyPut<AddPlayerUseCase>(() => AddPlayerUseCase(Get.find<PlayerLocalStorage>()));

}
