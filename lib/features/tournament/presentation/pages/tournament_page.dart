import 'package:flutter/material.dart';
import '../../domain/usecases/shuffle_players_usecase.dart';
import '../../data/models/player_model.dart';
import '../../domain/usecases/determine_winners_usecase.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}


class _TournamentPageState extends State<TournamentPage> {
  final ShufflePlayersUsecase _shufflePlayersUsecase = ShufflePlayersUsecase();
  final DetermineWinnersUsecase _determineWinnersUsecase =
  DetermineWinnersUsecase();

  List<Player> players = [
    Player(name: 'John Doe', gamerTag: 'JD123', imageUrl: ''),
    Player(name: 'Jane Smith', gamerTag: 'JS456', imageUrl: ''),
    Player(name: 'Mike Johnson', gamerTag: 'MJ789', imageUrl: ''),
    Player(name: 'Alice Brown', gamerTag: 'AB321', imageUrl: ''),
    Player(name: 'Marc Spencer', gamerTag: 'AB322', imageUrl: ''),
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
      pairs = _shufflePlayersUsecase(players); // Generate new pairs
      round++;
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
    );
  }
}