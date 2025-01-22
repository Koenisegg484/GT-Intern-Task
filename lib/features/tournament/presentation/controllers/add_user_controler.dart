import 'package:get/get.dart';

class AddUserController extends GetxController{
  var playerName = ''.obs;
  var gamersTagID = ''.obs;

  void setPlayerName(String value) {
    playerName.value = value;
  }

  void setGamersTagID(String value) {
    gamersTagID.value = value;
  }
}
