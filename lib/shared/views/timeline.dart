import 'package:flutter/material.dart';
import '../../core/models/timeline_model.dart';
import 'package:get/get.dart';
import '../controllers/timeline_controller.dart';


class AppColors {
  static const Color primaryBlue = Color(0xFF167CD0);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color darkRed = Color(0xFF8A0000);
  static const Color veryDarkRed = Color(0xFF230F0F);
  static const Color orangeRed = Color(0xFFDD3D00);
  static const Color gold = Color(0xFFF7CB1D);
  static const Color yellow = Color(0xFFFACC15);
  static const Color amber300 = Color(0xFFFFD54F);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color darkGrey = Color(0xFF29292F);
  static const Color white = Color(0xFFFFFFFF);
}

class TimelineScreen extends StatelessWidget {
  TimelineScreen({Key? key}) : super(key: key);

  // Initialize the controller
  final TimelineController controller = Get.put(TimelineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Events Calendar',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: AppColors.darkGrey,
          ),
        ),
        centerTitle: true,
      ),
      // Obx listens for changes in isLoading, hasError, and activeEvents
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.slate400),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: AppColors.slate600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                  ),
                  onPressed: controller.fetchEvents,
                  child: const Text("Retry", style: TextStyle(color: AppColors.white)),
                )
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildToggleSwitch(),
              ScheduleListView(events: controller.activeEvents),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildToggleSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.slate200.withOpacity(0.5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: ['Patna', 'Bihta'].map((loc) {
            bool isSelected = controller.currentLocation.value == loc;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.toggleLocation(loc);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.3),
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
                      color: isSelected ? AppColors.white : AppColors.slate600,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ScheduleListView extends StatefulWidget {
  final List<FestEvent> events;

  const ScheduleListView({Key? key, required this.events}) : super(key: key);

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView> {
  late DateTime _selectedDate;
  late DateTime _viewMonth;
  late ScrollController _calendarScrollController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _viewMonth = DateTime(_selectedDate.year, _selectedDate.month);

    double initialOffset = (_selectedDate.day - 1) * 68.0;
    _calendarScrollController = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  void dispose() {
    _calendarScrollController.dispose();
    super.dispose();
  }

  void _jumpToToday() {
    setState(() {
      _selectedDate = DateTime.now();
      _viewMonth = DateTime(_selectedDate.year, _selectedDate.month);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_calendarScrollController.hasClients) {
        double offset = (_selectedDate.day - 1) * 68.0;
        _calendarScrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  String _formatEventDate(DateTime date) {
    String suffix = 'th';
    if (date.day >= 11 && date.day <= 13) {
      suffix = 'th';
    } else if (date.day % 10 == 1) {
      suffix = 'st';
    } else if (date.day % 10 == 2) {
      suffix = 'nd';
    } else if (date.day % 10 == 3) {
      suffix = 'rd';
    }

    String month = '';
    switch (date.month) {
      case 2: month = 'Feb'; break;
      case 3: month = 'March'; break;
      case 4: month = 'April'; break;
      default: month = 'Feb';
    }
    return "${date.day}$suffix $month";
  }

  void _changeMonth(int offset) {
    setState(() {
      int newMonth = _viewMonth.month + offset;
      int newYear = _viewMonth.year;
      if (newMonth > 12) { newMonth = 1; newYear++; }
      if (newMonth < 1) { newMonth = 12; newYear--; }

      _viewMonth = DateTime(newYear, newMonth);
      _selectedDate = DateTime(newYear, newMonth, 1);

      if (_calendarScrollController.hasClients) {
        _calendarScrollController.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedSelectedDate = _formatEventDate(_selectedDate);
    List<FestEvent> filteredEvents = widget.events.where((e) => e.date == formattedSelectedDate).toList();

    return Column(
      children: [
        _buildCalendarHeader(),
        filteredEvents.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: EventCard(event: filteredEvents[index]),
                  );
                },
              ),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    String monthName = months[_viewMonth.month - 1];
    int daysInMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 0).day;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.slate200.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate200.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _changeMonth(-1),
                      child: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: AppColors.slate500),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$monthName ${_viewMonth.year}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => _changeMonth(1),
                      child: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.slate500),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: _jumpToToday,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.blue50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 12, color: AppColors.primaryBlue),
                        SizedBox(width: 4),
                        Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              controller: _calendarScrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                DateTime date = DateTime(_viewMonth.year, _viewMonth.month, index + 1);
                bool isSelected = date.year == _selectedDate.year &&
                    date.month == _selectedDate.month &&
                    date.day == _selectedDate.day;

                const daysOfWeek = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
                String dayName = daysOfWeek[date.weekday - 1];

                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 60,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.yellow : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? AppColors.white : AppColors.slate400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day < 10 ? '0' : ''}${date.day}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: isSelected ? AppColors.white : AppColors.slate500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.slate200.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.event_available_rounded, size: 48, color: AppColors.slate400),
            ),
            const SizedBox(height: 16),
            const Text(
              "No events scheduled",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.slate600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try selecting a different date.",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.slate400.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final FestEvent event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  IconData _getEventIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('badminton') || lowerTitle.contains('tennis')) return Icons.sports_tennis;
    if (lowerTitle.contains('football') || lowerTitle.contains('soccer')) return Icons.sports_soccer;
    if (lowerTitle.contains('basketball')) return Icons.sports_basketball;
    if (lowerTitle.contains('cricket')) return Icons.sports_cricket;
    if (lowerTitle.contains('chess')) return Icons.casino;
    if (lowerTitle.contains('singing') || lowerTitle.contains('music')) return Icons.music_note;
    if (lowerTitle.contains('dance')) return Icons.directions_run;
    if (lowerTitle.contains('yoga')) return Icons.self_improvement;
    if (lowerTitle.contains('hackathon') || lowerTitle.contains('tech')) return Icons.computer;
    return Icons.event;
  }

  Color _getEventAccentColor(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('qua') || lowerTitle.contains('sports') || lowerTitle.contains('cricket') || lowerTitle.contains('football')) return AppColors.orangeRed;
    if (lowerTitle.contains('dance') || lowerTitle.contains('singing') || lowerTitle.contains('music')) return AppColors.primaryBlue;
    return AppColors.primaryBlue;
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getEventAccentColor(event.title);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200.withOpacity(0.6), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate200.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getEventIcon(event.title),
                        color: accentColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkGrey,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.blue50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.blue100, width: 0.5),
                                ),
                                child: Text(
                                  _getShortTag(event.club),
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBlue,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 13, color: AppColors.slate400),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  event.venue,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.slate500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 13, color: AppColors.slate400),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  event.time,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.slate500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.groups_outlined, size: 13, color: AppColors.slate400),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  event.club,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.slate500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortTag(String club) {
    if (club.toLowerCase().contains("recreation") || club.toLowerCase().contains("outdoor")) return "SPORTS";
    if (club.toLowerCase().contains("dance") || club.toLowerCase().contains("music") || club.toLowerCase().contains("drama")) return "CULTURAL";
    if (club.toLowerCase().contains("art") || club.toLowerCase().contains("literary")) return "LITERARY";
    if (club.toLowerCase().contains("yoga")) return "WELLNESS";
    return "FEST";
  }
}