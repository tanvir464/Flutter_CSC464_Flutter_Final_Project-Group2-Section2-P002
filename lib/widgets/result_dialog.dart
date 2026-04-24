import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../screens/name_entry_screen.dart';
import '../theme/app_theme.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({super.key});

  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (ctx, _, _) => ChangeNotifierProvider.value(
        value: context.read<GameProvider>(),
        child: const ResultDialog(),
      ),
      transitionBuilder: (ctx, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
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
            // Animated icon
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              builder: (_, v, child) =>
                  Transform.scale(scale: v, child: child),
              child: Container(
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => const NameEntryScreen()),
                  );
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
