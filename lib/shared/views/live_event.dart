import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/models/score_event_model.dart';
import '../controllers/live_event_controller.dart';

class LiveEventsView extends StatelessWidget {
  const LiveEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final LiveEventController controller = Get.put(LiveEventController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Ensures default back button doesn't appear
        title: Text(
          'Live Action',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: Colors.red[600],
          backgroundColor: Colors.white,
          onRefresh: () => controller.fetchLiveScores(isRefresh: true),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh always works
            slivers: [
              // 1. All Top Filters wrapped in SliverToBoxAdapter
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Campus Toggle Switch
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Obx(() {
                          String currentLoc = controller.selectedCampus.value;
                          return Row(
                            children: ['Bihta', 'Patna'].map((loc) {
                              bool isSelected = currentLoc == loc;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.setCampus(loc),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.blue[600] : Colors.transparent,
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: Colors.blue.withOpacity(0.3),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      loc,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.grey[700],
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                    ),

                    // Search Bar + Live Toggle Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: TextField(
                                onChanged: (val) => controller.searchQuery.value = val,
                                decoration: InputDecoration(
                                  hintText: 'Search events...',
                                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                                  prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Live Only',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Obx(() => Switch(
                                    value: controller.showOnlyLive.value,
                                    onChanged: controller.toggleLiveFilter,
                                    activeColor: Colors.red[600],
                                    activeTrackColor: Colors.red[200],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtle "Pull to Refresh" User Hint
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard_double_arrow_down_rounded, size: 16, color: Colors.grey[400]),
                        const SizedBox(width: 6),
                        Text(
                          'Pull down to refresh live scores',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.keyboard_double_arrow_down_rounded, size: 16, color: Colors.grey[400]),
                      ],
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // 2. The Dynamic List
              Obx(() {
                if (controller.isLoading.value) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final filtered = controller.filteredEvents;

                if (filtered.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sports_score_rounded, size: 64, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            "No events match your filters.",
                            style: TextStyle(color: Colors.grey[500], fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 120),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: LiveScoreCard(event: filtered[index]),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SCORECARD WIDGET ---
class LiveScoreCard extends StatelessWidget {
  final LiveEventModel event;

  const LiveScoreCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String teamA = event.teamNames.isNotEmpty ? event.teamNames[0] : 'Team A';
    String teamB = event.teamNames.length > 1 ? event.teamNames[1] : 'Team B';
    String scoreA = event.scores.isNotEmpty ? event.scores[0].toString() : '0';
    String scoreB = event.scores.length > 1 ? event.scores[1].toString() : '0';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: event.isLive ? Colors.red[100]! : Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: event.isLive ? Colors.red.withOpacity(0.08) : Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: event.isLive ? Colors.red[50]?.withOpacity(0.8) : Colors.grey[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: event.isLive ? Colors.red[100]! : Colors.grey[100]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12, color: Colors.blue[600]),
                          const SizedBox(width: 4),
                          Text(
                            event.campus,
                            style: TextStyle(color: Colors.blue[600], fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (event.isLive)
                  const PulsingLiveIndicator()
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'FINISHED',
                      style: TextStyle(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        scoreA,
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teamA,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Text(
                    "VS",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        scoreB,
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teamB,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!event.isLive && event.winner != null && event.winner!.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFFFCA28),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.emoji_events_rounded, color: Colors.black87, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Winner: ${event.winner}",
                    style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// --- CONTINUOUS BLINKING ANIMATION ---
class PulsingLiveIndicator extends StatefulWidget {
  const PulsingLiveIndicator({super.key});

  @override
  State<PulsingLiveIndicator> createState() => _PulsingLiveIndicatorState();
}

class _PulsingLiveIndicatorState extends State<PulsingLiveIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Opacity(
                  opacity: _animation.value,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          const Text(
            'LIVE',
            style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}