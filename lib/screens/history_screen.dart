import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match_record.dart';
import '../services/firestore_service.dart';
import '../theme/app_theme.dart';
import '../widgets/history_tile_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<MatchRecord>> _matchesFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _matchesFuture = context.read<FirestoreService>().fetchMatches();
  }

  Future<void> _refresh() async {
    setState(() => _load());
    await _matchesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match History')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppTheme.primary,
        child: FutureBuilder<List<MatchRecord>>(
          future: _matchesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.primary),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Failed to load history',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              );
            }

            final matches = snapshot.data ?? [];
            if (matches.isEmpty) {
              return const _EmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: matches.length,
              itemBuilder: (_, i) => HistoryTileWidget(record: matches[i]),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_esports_outlined,
              size: 64, color: AppTheme.textSecondary),
          SizedBox(height: 16),
          Text(
            'No matches yet',
            style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
          ),
          SizedBox(height: 8),
          Text(
            'Play a game to see your history here',
            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
