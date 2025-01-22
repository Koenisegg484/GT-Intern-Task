import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:knockout_tournament/core/utils/screen_utils.dart';
import 'package:knockout_tournament/features/tournament/presentation/pages/tournament_page2.dart';
import 'package:knockout_tournament/injection.dart';

import 'features/tournament/presentation/pages/tournament_page.dart';

void main() async {
  // Initialising Hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Initiatiing dependencies injection
  setupDependencyInjection();

  // Runs the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Knockout Tournament',
      home: const TournamentPage2(),
    );
  }
}
