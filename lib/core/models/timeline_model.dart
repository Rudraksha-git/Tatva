// lib/core/models/fest_event.dart

class FestEvent {
  final String date;
  final String title;
  final String time;
  final String venue;
  final String club;

  const FestEvent({
    required this.date,
    required this.title,
    required this.time,
    required this.venue,
    required this.club,
  });

  factory FestEvent.fromJson(Map<String, dynamic> json) {
    return FestEvent(
      date: json['date'] as String,
      title: json['title'] as String,
      time: json['time'] as String,
      venue: json['venue'] as String,
      club: json['club'] as String,
    );
  }
}