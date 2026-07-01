import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailDialog extends StatelessWidget {
  final String title;
  final String body;
  final String time;
  final String? imageUrl;
  final String? ctaLabel;
  final String? ctaUrl;

  const AnnouncementDetailDialog({
    Key? key,
    required this.title,
    required this.body,
    required this.time,
    this.imageUrl,
    this.ctaLabel,
    this.ctaUrl,
  }) : super(key: key);

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image Header (if any)
            if (imageUrl != null && imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.network(
                  imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[100],
                      alignment: Alignment.center,
                      child: Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey[400]),
                    );
                  },
                ),
              )
            else
              const SizedBox(height: 24), // Top padding if no image

            // Content Body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 16, color: Colors.blue[600]),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        body,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[800],
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Call to Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                      ),
                      child: const Text(
                        "Close",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  ),
                  if (ctaLabel != null && ctaLabel!.isNotEmpty && ctaUrl != null && ctaUrl!.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () => _launchUrl(ctaUrl!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          ctaLabel!,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
