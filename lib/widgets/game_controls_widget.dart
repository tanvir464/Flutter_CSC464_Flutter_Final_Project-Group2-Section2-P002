import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../screens/name_entry_screen.dart';
import '../theme/app_theme.dart';

class GameControlsWidget extends StatelessWidget {
  const GameControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _ControlButton(
            icon: Icons.refresh,
            label: 'Reset',
            onTap: () => context.read<GameProvider>().resetBoard(),
          ),
          const SizedBox(width: 10),
          _ControlButton(
            icon: Icons.swap_horiz,
            label: 'Switch Starter',
            onTap: () => context.read<GameProvider>().switchStartingPlayer(),
          ),
          const SizedBox(width: 10),
          _ControlButton(
            icon: Icons.person_outline,
            label: 'Change Names',
            onTap: () {
              context.read<GameProvider>().resetAll();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => const NameEntryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          side: const BorderSide(color: AppTheme.divider),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppTheme.textSecondary),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
