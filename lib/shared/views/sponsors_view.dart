import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fest_app/shared/widgets/sponsor_card.dart';

class Sponsor {
  final String name;
  final String logoUrl;
  final String description;
  final String? linkUrl;
  final String category;

  Sponsor({
    required this.name,
    required this.logoUrl,
    required this.description,
    this.linkUrl,
    required this.category,
  });
}

class SponsorsView extends StatelessWidget {
  SponsorsView({Key? key}) : super(key: key);

  // High-quality mock data populated for verification
  final List<Sponsor> sponsors = [
    Sponsor(
      name: "TechNova Corp",
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/1200px-Amazon_logo.svg.png",
      description: "Empowering infinite engineering possibilities.",
      linkUrl: "https://amazon.com",
      category: "Title Sponsor",
    ),
    Sponsor(
      name: "Nexus Innovate",
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg",
      description: "Building the digital future of smart infrastructure.",
      linkUrl: "https://google.com",
      category: "Title Sponsor",
    ),
    Sponsor(
      name: "Acme Dynamics",
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg",
      description: "Your partner in seamless global logistics.",
      linkUrl: "https://microsoft.com",
      category: "Gold Sponsor",
    ),
    Sponsor(
      name: "CloudSynergy",
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IBM_logo.svg/1200px-IBM_logo.svg.png",
      description: "Next-gen scalable enterprise cloud solutions.",
      linkUrl: "https://ibm.com",
      category: "Gold Sponsor",
    ),
    Sponsor(
      name: "Pulse Media",
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/YouTube_Logo_2017.svg/1200px-YouTube_Logo_2017.svg.png",
      description: "Delivering vibrant entertainment directly to you.",
      linkUrl: "https://youtube.com",
      category: "Silver Sponsor",
    ),
    Sponsor(
      name: "EcoSphere",
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Spotify_logo_with_text.svg/1200px-Spotify_logo_with_text.svg.png",
      description: "Sustainable engineering for a better tomorrow.",
      linkUrl: "https://spotify.com",
      category: "Silver Sponsor",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final titleSponsors = sponsors.where((s) => s.category == "Title Sponsor").toList();
    final goldSponsors = sponsors.where((s) => s.category == "Gold Sponsor").toList();
    final silverSponsors = sponsors.where((s) => s.category == "Silver Sponsor").toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Our Sponsors",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          if (titleSponsors.isNotEmpty) ...[
            _buildSectionHeader("Title Sponsors", Colors.purple[700]!, Icons.star_rounded),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sponsor = titleSponsors[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: 250, // Prominent large landscape card
                        child: SponsorCard(
                          name: sponsor.name,
                          logoUrl: sponsor.logoUrl,
                          description: sponsor.description,
                          linkUrl: sponsor.linkUrl,
                          category: sponsor.category,
                          isLarge: true,
                        ),
                      ),
                    );
                  },
                  childCount: titleSponsors.length,
                ),
              ),
            ),
          ],
          if (goldSponsors.isNotEmpty) ...[
            _buildSectionHeader("Gold Sponsors", Colors.orange[600]!, Icons.workspace_premium_rounded),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8, // balances logos vs descriptions beautifully
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sponsor = goldSponsors[index];
                    return SponsorCard(
                      name: sponsor.name,
                      logoUrl: sponsor.logoUrl,
                      description: sponsor.description,
                      linkUrl: sponsor.linkUrl,
                      category: sponsor.category,
                      isLarge: false,
                    );
                  },
                  childCount: goldSponsors.length,
                ),
              ),
            ),
          ],
          if (silverSponsors.isNotEmpty) ...[
            _buildSectionHeader("Silver Sponsors", Colors.blueGrey[400]!, Icons.verified_rounded),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sponsor = silverSponsors[index];
                    return SponsorCard(
                      name: sponsor.name,
                      logoUrl: sponsor.logoUrl,
                      description: sponsor.description,
                      linkUrl: sponsor.linkUrl,
                      category: sponsor.category,
                      isLarge: false,
                    );
                  },
                  childCount: silverSponsors.length,
                ),
              ),
            ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color accentColor, IconData icon) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: -0.5),
            ),
          ],
        ),
      ),
    );
  }
}
