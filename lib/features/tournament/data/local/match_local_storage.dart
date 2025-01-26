import 'package:hive_flutter/adapters.dart';

import '../models/match_model.dart';


class TournamentMatchLocalStorage{
  static const String boxName = "matches";

  Future<void> addMatch(TournamentMatch match) async{
    final box = await Hive.openBox<TournamentMatch>(boxName);
    await box.add(match);
    print("Match has been added");
  }

  Future<List<TournamentMatch>> get matches async{
    final box = await Hive.openBox<TournamentMatch>(boxName);
    return box.values.toList();
  }


  Future<TournamentMatch?> getMatchById(String id) async {
    final box = await Hive.openBox<TournamentMatch>(boxName);
    return box.values.cast<TournamentMatch?>().firstWhere(
          (match) => match?.id == id,
      orElse: () => null,
    );
  }


  Future<void> updateMatch(TournamentMatch updatedMatch) async {
    final box = await Hive.openBox<TournamentMatch>(boxName);
    final matches = box.values.toList();

    for (var match in matches) {
      if (match.id == updatedMatch.id) {
        await box.put(match.key, updatedMatch);
        print("Match updated successfully");
        return;
      }
    }
  }


  Future<void> removeMatch(TournamentMatch match) async{
    final box = await Hive.openBox<TournamentMatch>(boxName);
    List<TournamentMatch> matches = box.values.toList();

    for(TournamentMatch m in matches){
      if(m.id == match.id){
        await box.delete(m.key);
        return;
      }
    }
  }
}