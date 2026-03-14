import 'package:flutter/material.dart';

class SportsEventCard extends StatelessWidget {
  final String sportName;
  final String date;
  final String location;
  final String description;
  final String imageUrl;
  final bool isRegistrationOpen;
  final VoidCallback onRegister;
  final VoidCallback onCardTap;

  const SportsEventCard({
    super.key,
    required this.sportName,
    required this.date,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.isRegistrationOpen,
    required this.onRegister,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic pill badge colors based on sport type (just for visual variety)
    bool isEsports = sportName.toLowerCase().contains('esport');
    Color pillBgColor = isEsports ? Colors.purple[100]! : Colors.green[100]!;
    Color pillTextColor = isEsports ? Colors.purple[800]! : Colors.green[800]!;
    String shortCategory = isEsports ? 'ESPORTS' : 'SPORT';

    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(Icons.sports_volleyball, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          sportName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: pillBgColor, borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          shortCategory,
                          style: TextStyle(color: pillTextColor, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 16, color: Colors.blue[600]),
                      const SizedBox(width: 6),
                      Text(date, style: TextStyle(color: Colors.blue[600], fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(location, style: TextStyle(color: Colors.grey[600], fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.4),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: isRegistrationOpen ? onRegister : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFCA28),
                        disabledBackgroundColor: Colors.grey[300],
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      ),
                      child: Text(
                        isRegistrationOpen ? 'Register Now' : 'Registration Closed',
                        style: TextStyle(color: isRegistrationOpen ? Colors.black87 : Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}