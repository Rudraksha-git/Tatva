class LiveEventModel {
  final String eventName;
  final String campus;
  final bool isLive;
  final String? winner;
  final List<String> teamNames;
  final List<int> scores;

  LiveEventModel({
    required this.eventName,
    required this.campus,
    required this.isLive,
    this.winner,
    required this.teamNames,
    required this.scores,
  });

  factory LiveEventModel.fromJson(Map<String, dynamic> json) {
    return LiveEventModel(
      eventName: json['event_name'] ?? 'Unknown Event',
      campus: json['campus'] ?? 'Unknown',
      isLive: json['is_live'] ?? false,
      winner: json['winner'],
      teamNames: List<String>.from(json['team_names'] ?? []),
      scores: List<int>.from(json['score'] ?? []),
    );
  }
}