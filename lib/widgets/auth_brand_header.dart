import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AuthBrandHeader extends StatelessWidget {
  final String subtitle;
  const AuthBrandHeader({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.divider),
          ),
          child: const Center(
            child: Text(
              'X O',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
                letterSpacing: 4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
