import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../providers/game_provider.dart';
import '../widgets/board_widget.dart';
import '../widgets/game_controls_widget.dart';
import '../widgets/player_turn_banner.dart';
import '../widgets/result_dialog.dart';
import '../widgets/scoreboard_widget.dart';
import 'history_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final status = context.select<GameProvider, GameStatus>((p) => p.status);

    if ((status == GameStatus.won || status == GameStatus.tied) && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) ResultDialog.show(context);
      });
    }

    if (status == GameStatus.inProgress) {
      _dialogShown = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Match History',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const ScoreboardWidget(),
            const SizedBox(height: 16),
            const PlayerTurnBanner(),
            const BoardWidget(),
            const Spacer(),
            const GameControlsWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
