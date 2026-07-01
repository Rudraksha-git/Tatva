import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorCard extends StatelessWidget {
  final String name;
  final String logoUrl;
  final String description;
  final String? linkUrl;
  final String category;
  final bool isLarge;

  const SponsorCard({
    Key? key,
    required this.name,
    required this.logoUrl,
    required this.description,
    this.linkUrl,
    required this.category,
    this.isLarge = false,
  }) : super(key: key);

  Future<void> _launchUrl() async {
    if (linkUrl == null || linkUrl!.isEmpty) return;
    final Uri url = Uri.parse(linkUrl!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $linkUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _launchUrl,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo Section
              Expanded(
                flex: isLarge ? 4 : 3,
                child: Container(
                  padding: EdgeInsets.all(isLarge ? 24 : 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Image.network(
                    logoUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business_rounded, color: Colors.grey[400], size: isLarge ? 60 : 40);
                    },
                  ),
                ),
              ),
              const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
              // Text Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: isLarge ? 18 : 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: isLarge ? 14 : 12,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (category.isNotEmpty && isLarge) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue[700],
                            letterSpacing: 0.5,
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
      ),
    );
  }
}
