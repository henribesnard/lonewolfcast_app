import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/match_card.dart';
import '../models/match.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final DatabaseReference _matchesRef = FirebaseDatabase.instance.ref('matches');
  List<Match> _liveMatches = [];
  List<Match> _upcomingMatches = [];
  List<Match> _finishedMatches = [];

  @override
  void initState() {
    super.initState();
    _setupMatchesListener();
  }

  void _setupMatchesListener() {
    _matchesRef.onValue.listen((event) {
      if (!event.snapshot.exists) return;

      final matchesData = Map<String, dynamic>.from(
        event.snapshot.value as Map
      );

      final allMatches = matchesData.entries.map((entry) {
        return Match.fromJson(Map<String, dynamic>.from(entry.value));
      }).toList();

      setState(() {
        _liveMatches = allMatches.where((m) => m.isLive).toList();
        _upcomingMatches = allMatches.where((m) => m.isUpcoming).toList();
        _finishedMatches = allMatches.where((m) => m.isFinished).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchs du jour'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          if (_liveMatches.isNotEmpty) ...[
            _buildSectionHeader('En Direct', Colors.red),
            ..._liveMatches.map((match) => MatchCard(match: match)),
          ],
          if (_upcomingMatches.isNotEmpty) ...[
            _buildSectionHeader('À Venir', Colors.blue),
            ..._upcomingMatches.map((match) => MatchCard(match: match)),
          ],
          if (_finishedMatches.isNotEmpty) ...[
            _buildSectionHeader('Terminés', Colors.grey),
            ..._finishedMatches.map((match) => MatchCard(match: match)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}