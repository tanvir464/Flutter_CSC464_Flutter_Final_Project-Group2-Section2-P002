import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';

class BoardCellWidget extends StatelessWidget {
  final int index;

  const BoardCellWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final value = provider.board[index];
    final isWinningCell = provider.winningIndices.contains(index);

    return GestureDetector(
      onTap: () => context.read<GameProvider>().makeMove(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isWinningCell
              ? AppTheme.winnerColor(provider.winner ?? '').withValues(alpha: 0.22)
              : AppTheme.cellColor(value),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isWinningCell
                ? AppTheme.winnerColor(provider.winner ?? '')
                : AppTheme.divider,
            width: isWinningCell ? 2.0 : 1.0,
          ),
          boxShadow: isWinningCell
              ? [
                  BoxShadow(
                    color: AppTheme.winnerColor(provider.winner ?? '')
                        .withValues(alpha: 0.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut,
              ),
              child: child,
            ),
            child: Text(
              value,
              key: ValueKey(value),
              style: AppTheme.cellTextStyle.copyWith(
                color: AppTheme.cellTextColor(value),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
