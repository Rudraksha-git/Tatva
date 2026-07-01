class NotificationModel {
  final String title;
  final String subtitle;
  final String body;
  final DateTime timestamp;
  final String emoji;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.body,
    required this.timestamp,
    required this.emoji,
  });

  String getTimeAgo() {
  final Duration difference = DateTime.now().difference(timestamp);

  if (difference.inDays > 365) {
    final int years = (difference.inDays / 365).floor();
    return '$years year${years == 1 ? '' : 's'} ago';
  } else if (difference.inDays >= 30) {
    final int months = (difference.inDays / 30).floor();
    return '$months month${months == 1 ? '' : 's'} ago';
  } else if (difference.inDays >= 7) {
    final int weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks == 1 ? '' : 's'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else if (difference.inSeconds > 5) {
    return '${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'Just now';
  }
}
}