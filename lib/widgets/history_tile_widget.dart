import 'package:flutter/material.dart';
import '../models/match_record.dart';
import '../theme/app_theme.dart';

class HistoryTileWidget extends StatelessWidget {
  final MatchRecord record;

  const HistoryTileWidget({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.winnerColor(record.winner);
    final label = record.winner == 'Tie' ? 'Tie' : '${record.winner} Won';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          '${record.player1} vs ${record.player2}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        subtitle: Text(
          record.createdAt.toLocal().toString().substring(0, 16),
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
