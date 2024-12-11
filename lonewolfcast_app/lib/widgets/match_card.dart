import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final matchTime = match.fixture.date != null 
        ? DateFormat('HH:mm').format(DateTime.parse(match.fixture.date!))
        : '--:--';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildLeagueInfo(),
            const SizedBox(height: 16),
            _buildMatchInfo(matchTime),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueInfo() {
    return Row(
      children: [
        Image.network(
          match.league.logo ?? '',
          width: 24,
          height: 24,
          errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            match.league.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchInfo(String matchTime) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.network(
                match.teams.home.logo ?? '',
                height: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer),
              ),
              const SizedBox(height: 8),
              Text(
                match.teams.home.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        _buildScore(matchTime),
        Expanded(
          child: Column(
            children: [
              Image.network(
                match.teams.away.logo ?? '',
                height: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer),
              ),
              const SizedBox(height: 8),
              Text(
                match.teams.away.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScore(String matchTime) {
    final isLive = match.isLive;
    final textColor = isLive ? Colors.red : Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isLive ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            isLive
                ? '${match.goals?.home ?? 0} - ${match.goals?.away ?? 0}'
                : matchTime,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          if (isLive && match.fixture.status.elapsed != null) ...[
            const SizedBox(height: 4),
            Text(
              '${match.fixture.status.elapsed}\'',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}