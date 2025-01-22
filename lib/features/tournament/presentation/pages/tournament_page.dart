import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockout_tournament/features/tournament/presentation/widgets/add_player_popup.dart';
import '../../domain/usecases/shuffle_players_usecase.dart';
import '../../domain/usecases/determine_winners_usecase.dart';
import '../../data/models/player_model.dart';
import '../widgets/add_player_dialog.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  final ShufflePlayersUsecase _shufflePlayersUsecase = ShufflePlayersUsecase();
  final DetermineWinnersUsecase _determineWinnersUsecase = DetermineWinnersUsecase();

  List<Player> players = [
    Player(name: 'John Doe', gamerTag: 'JD123', imageUrl: ''),
    Player(name: 'Jane Smith', gamerTag: 'JS456', imageUrl: ''),
    Player(name: 'Mike Johnson', gamerTag: 'MJ789', imageUrl: ''),
    Player(name: 'Alice Brown', gamerTag: 'AB321', imageUrl: ''),
    Player(name: 'Marc Spencer', gamerTag: 'MS322', imageUrl: ''),
  ];

  List<List<Player>> pairs = [];
  int round = 1;

  void shuffleAndGeneratePairs() {
    setState(() {
      pairs = _shufflePlayersUsecase(players);
      round = 1;
    });
  }

  void progressToNextRound() {
    setState(() {
      players = _determineWinnersUsecase(pairs);
      pairs = _shufflePlayersUsecase(players);
      round++;
    });
  }

  // Function to handle winner selection for a match
  void _selectWinner(List<Player> pair) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Winner'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(pair[0].name),
                leading: Radio<Player>(
                  value: pair[0],
                  groupValue: pair.firstWhere(
                        (player) => player.isWinner,
                    orElse: () => pair[0],
                  ),
                  onChanged: (Player? selectedPlayer) {
                    _updateWinner(pair, selectedPlayer!);
                    Get.back();
                  },
                ),
              ),
              ListTile(
                title: Text(pair[1].name),
                leading: Radio<Player>(
                  value: pair[1],
                  groupValue: pair.firstWhere(
                        (player) => player.isWinner,
                    orElse: () => pair[0],
                  ),
                  onChanged: (Player? selectedPlayer) {
                    _updateWinner(pair, selectedPlayer!);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  void _updateWinner(List<Player> pair, Player selectedPlayer) {
    for (var player in pair) {
      player.isWinner = false;
    }
    selectedPlayer.isWinner = true;
    setState(() {
      players = players.where((player) => player.isWinner).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knockout Tournament - Round $round'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: shuffleAndGeneratePairs,
            child: const Text('Start Tournament'),
          ),
          ElevatedButton(
            onPressed: players.length > 1 ? progressToNextRound : null,
            child: const Text('Next Round'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pairs.length,
              itemBuilder: (context, index) {
                final pair = pairs[index];
                return ListTile(
                  title: Text(
                    pair.length == 2
                        ? '${pair[0].name} vs ${pair[1].name}'
                        : '${pair[0].name} gets a bye',
                  ),
                  onTap: () => _selectWinner(pair),
                );
              },
            ),
          ),
          if (players.length == 1)
            Center(
              child: Text(
                'Tournament Winner: ${players.first.name}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddPlayerDialog(oprTitle: "ADD TITLE", btnTitle: "ADD", onPressed: (player) {
                Get.snackbar("Dialogue", "was pressed");
              },);
              // return AddPlayerPopup();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}