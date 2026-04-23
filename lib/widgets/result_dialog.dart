import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<GameProvider>(),
        child: const ResultDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GameProvider>();
    final winner = provider.winner ?? '';
    final isTie = winner == 'Tie';
    final color = AppTheme.winnerColor(winner);

    final title = isTie
        ? "It's a Tie!"
        : winner == 'X'
            ? '${provider.player1Name} wins!'
            : '${provider.player2Name} wins!';

    final subtitle = isTie ? 'Well played by both!' : '$winner takes the round';

    return Dialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trophy / tie icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isTie ? '🤝' : '🏆',
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<GameProvider>().resetBoard();
                },
                child: const Text('Play Again'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<GameProvider>().resetAll();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Change Names'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
