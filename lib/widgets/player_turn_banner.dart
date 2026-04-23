import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';

class PlayerTurnBanner extends StatelessWidget {
  const PlayerTurnBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();

    if (provider.status != GameStatus.inProgress) {
      return const SizedBox(height: 48);
    }

    final isX = provider.currentPlayer == Player.X;
    final color = isX ? AppTheme.xColor : AppTheme.oColor;
    final mark = isX ? 'X' : 'O';
    final name = provider.currentPlayerName;

    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mark,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$name's turn",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
