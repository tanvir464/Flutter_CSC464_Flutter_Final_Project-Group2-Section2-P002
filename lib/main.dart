import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/name_entry_screen.dart';
import 'services/firestore_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        ChangeNotifierProvider<GameProvider>(
          create: (ctx) => GameProvider(ctx.read<FirestoreService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Tic Tac Toe',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const NameEntryScreen(),
      ),
    );
  }
}
