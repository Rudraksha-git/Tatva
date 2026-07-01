import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// --- APP COLORS ---
class AppColors {
  static const Color primaryBlue = Color(0xFF167CD0);
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

// --- URL LAUNCHER HELPERS ---
Future<void> _makePhoneCall(String phoneNumber) async {
  final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  final Uri launchUri = Uri(scheme: 'tel', path: cleanNumber);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    debugPrint('Could not launch $phoneNumber');
  }
}

Future<void> _sendEmail(String email) async {
  final Uri launchUri = Uri(scheme: 'mailto', path: email);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    debugPrint('Could not launch $email');
  }
}

// --- DATA MODELS ---
class TeamMember {
  final String name;
  final String role;
  final String? phone;
  final String? email;

  TeamMember({required this.name, required this.role, this.phone, this.email});
}

class TeamCategory {
  final String teamName;
  final List<TeamMember> members;

  TeamCategory({required this.teamName, required this.members});
}

// ==========================================
// DATA: PATNA CAMPUS
// ==========================================
final List<TeamCategory> patnaCoreTeam = [
  TeamCategory(teamName: "General Management", members: [
    TeamMember(name: "Manaswini Patil", role: "Student Coordinator", phone: "8275007608", email: "patilr.ug22.ar@nitp.ac.in"),
    TeamMember(name: "Harshvardhan Dansena", role: "Student Coordinator", phone: "8319728292", email: "harshvardhand.dd22.ce@nitp.ac.in"),
  ]),
];

final List<TeamCategory> patnaCommittees = [
  TeamCategory(teamName: "Sponsorship Leads", members: [
    TeamMember(name: "Krish Sinha", role: "Coordinator", phone: "7061896463", email: "krishs.ug23.ar@nitp.ac.in"),
    TeamMember(name: "Shivang", role: "Co-coordinator", phone: "7007154261", email: "shivangs.ug23.ce@nitp.ac.in"),
    TeamMember(name: "Priyanshu Goswami", role: "Co-coordinator", phone: "9470080599"),
  ]),
  TeamCategory(teamName: "Decoration", members: [
    TeamMember(name: "Sai Karthik", role: "Coordinator", phone: "9542379013"),
    TeamMember(name: "Boda Karthik", role: "Coordinator", phone: "9618190859"),
    TeamMember(name: "Samriddhi", role: "Co-coordinator", phone: "8287224470"),
  ]),
  TeamCategory(teamName: "Design", members: [
    TeamMember(name: "Subhadeep", role: "Coordinator", phone: "7047963335", email: "subhadeepd.ug23.ar@nitp.ac.in"),
    TeamMember(name: "Abhisth Vitan Ambasth", role: "Co-coordinator", phone: "9973555357", email: "abhistha.ug24.ar@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Media & PR", members: [
    TeamMember(name: "Sidram", role: "Coordinator", phone: "9353029255", email: "sidramd.ug23.ar@nitp.ac.in"),
    TeamMember(name: "Suhani", role: "Coordinator", phone: "7292015147", email: "suhani.ug23.ar@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Stage Management", members: [
    TeamMember(name: "Shanvi Dixit", role: "Coordinator", phone: "8810904010", email: "shanvid.ug23.ch@nitp.ac.in"),
    TeamMember(name: "Sanchita Jha", role: "Co-coordinator", phone: "8864014422"),
  ]),
];

final List<TeamCategory> patnaEventLeads = [
  TeamCategory(teamName: "Raaga", members: [
    TeamMember(name: "Vinayak Thakur", role: "Coordinator", phone: "6299099156", email: "vinayakk.ug23.ee@nitp.ac.in"),
    TeamMember(name: "Yash Kashyap", role: "Co-coordinator", phone: "8935923228"),
    TeamMember(name: "Yogaja Aasti", role: "Co-coordinator", phone: "7633974250"),
  ]),
  TeamCategory(teamName: "Nrityangna", members: [
    TeamMember(name: "Aditi Verma", role: "Coordinator", phone: "7318552617", email: "aditiv.ug23.me@nitp.ac.in"),
    TeamMember(name: "Anusha", role: "Co-coordinator", phone: "6290552969", email: "anusham.ug23.ar@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Kalakriti", members: [
    TeamMember(name: "Rohit Kumar", role: "Coordinator", phone: "7281903256", email: "rohitk.ug24.ce@nitp.ac.in"),
    TeamMember(name: "Mitali", role: "Co-coordinator", phone: "6204580397", email: "mitalir.ug24.ce@nitp.ac.in"),
    TeamMember(name: "Saksham", role: "Co-coordinator", phone: "6299446166", email: "sakshamk.ug24.ar@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Avlokan", members: [
    TeamMember(name: "Aparna", role: "Coordinator", phone: "9234758623", email: "aparnas.ug23.ar@nitp.ac.in"),
    TeamMember(name: "Bhavyanshi", role: "Co-coordinator", phone: "9829094848"),
    TeamMember(name: "Deepali", role: "Co-coordinator", phone: "7428485611", email: "deepalim.ug24.me@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Sanhita", members: [
    TeamMember(name: "Rishav", role: "Coordinator", phone: "7808108775"),
    TeamMember(name: "Satyam", role: "Co-coordinator", phone: "7765976599", email: "satyamk.ug24.ce@nitp.ac.in"),
    TeamMember(name: "Nitin", role: "Co-coordinator", phone: "9555631830", email: "nitint.ug24.me@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Abhinay", members: [
    TeamMember(name: "Aditya Raj", role: "Coordinator", phone: "8092189424"),
    TeamMember(name: "Manvi", role: "Co-coordinator", phone: "7023828264"),
  ]),
  TeamCategory(teamName: "Vistaakari", members: [
    TeamMember(name: "Niranjan", role: "Coordinator", phone: "9188394053", email: "niranjans.ug23.ar@nitp.ac.in"),
    TeamMember(name: "Abhay", role: "Co-coordinator", phone: "6201763933"),
  ]),
  TeamCategory(teamName: "Graphika", members: [
    TeamMember(name: "Bhanu Priya", role: "Coordinator", phone: "8235976798", email: "bhanup.ug23.ce@nitp.ac.in"),
    TeamMember(name: "Tabassum Bannerjee", role: "Co-coordinator", phone: "8170919828", email: "tabassumb.ug24.ar@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Pratibimb", members: [
    TeamMember(name: "Aditi Rao", role: "Coordinator", phone: "6264767138", email: "aditir.ug22.ar@nitp.ac.in"),
    TeamMember(name: "Jyoti Kumari", role: "Co-coordinator", phone: "9905657081", email: "jyotik.ug23.ar@nitp.ac"),
  ]),
  TeamCategory(teamName: "Outdoor Sports", members: [
    TeamMember(name: "Dishant", role: "Coordinator", phone: "7073421006", email: "dishantp.ug24.ce@nitp.ac.in"),
    TeamMember(name: "Prajwal", role: "Co-coordinator", phone: "8147950295", email: "prajwala.ug25.ce@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Indoor Sports", members: [
    TeamMember(name: "Daksh", role: "Coordinator", phone: "7737376294", email: "daksha.ug23.ce@nitp.ac.in"),
    TeamMember(name: "Archi", role: "Co-coordinator", phone: "6205240040"),
  ]),
];

// ==========================================
// DATA: BIHTA CAMPUS
// ==========================================
final List<TeamCategory> bihtaCoreTeam = [
  TeamCategory(teamName: "General Management", members: [
    TeamMember(name: "Anshuman Padhi", role: "Coordinator", phone: "9444314703", email: "anshumanp.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Aakash Tiwari", role: "Coordinator", phone: "7903490789", email: "aakasht.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Rahul Chaudhary", role: "Co-coordinator", phone: "9044344565", email: "rahulc.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Vikrant Prasad Singh", role: "Co-coordinator", phone: "9336683006", email: "vikrants.ug23.ec@nitp.ac.in"),
  ]),
];

final List<TeamCategory> bihtaCommittees = [
  TeamCategory(teamName: "Sponsorship Leads", members: [
    TeamMember(name: "Rachita Raman", role: "Coordinator", phone: "9321308542", email: "rachitar.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Akanksha Nigam", role: "Co-coordinator", phone: "9258323092", email: "akankshan.ug23.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Decoration", members: [
    TeamMember(name: "Saim Javed", role: "Coordinator", phone: "8235849155", email: "saimj.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Adarsh Kumar Dubey", role: "Co-coordinator", phone: "9709721788", email: "adarshd.ug23.ec@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Design", members: [
    TeamMember(name: "Muskaan", role: "Coordinator", phone: "8709179054", email: "muskaan.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Shreya", role: "Co-coordinator", phone: "9304722598", email: "shreya.ug24.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Media & PR", members: [
    TeamMember(name: "Jadhav Mohith", role: "Coordinator", phone: "8328112458", email: "jadhavm.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Siddharth Kumar", role: "Co-coordinator", phone: "9031446280", email: "siddharthk.ug24.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Stage Management", members: [
    TeamMember(name: "Harsh Kumar", role: "Coordinator", phone: "8409719691", email: "harshk.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Shreya Pandey", role: "Co-coordinator", phone: "7233002984", email: "shreyap.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Ashish Anand", role: "Co-coordinator", phone: "8051403975", email: "ashisha.ug23.ec@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Discipline", members: [
    TeamMember(name: "Nitish Rai", role: "Coordinator", phone: "7237908001", email: "nitishr.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Shreya Pandey", role: "Coordinator", phone: "7233002984", email: "shreyap.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Ratnesh Anand", role: "Co-coordinator", phone: "8409927332", email: "ratnesha.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Madhuram", role: "Co-coordinator"),
  ]),
];

final List<TeamCategory> bihtaEventLeads = [
  TeamCategory(teamName: "Raaga", members: [
    TeamMember(name: "Sarthak Rajan", role: "Coordinator", phone: "8354819414", email: "sarthakr.ug24.ec@nitp.ac.in"),
    TeamMember(name: "Yaksh Bariya", role: "Co-coordinator", phone: "9662435662", email: "yakshb.ug24.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Nrityangna", members: [
    TeamMember(name: "Talachintala Yashwanth", role: "Coordinator", phone: "9347803531", email: "talachintalay.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Sai Koushik", role: "Co-coordinator", phone: "7780154569", email: "puppalak.ug23.ec@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Kalakriti", members: [
    TeamMember(name: "Anurag Mishra", role: "Coordinator", phone: "7061633407", email: "anuragm.ug24.cs@nitp.ac.in"),
    TeamMember(name: "Khushbu Kumari", role: "Co-coordinator", phone: "8100918754", email: "khushbuk.ug24.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Treasure Hunt", members: [
    TeamMember(name: "Harshit Verma", role: "Coordinator", phone: "9838491852", email: "harshitv.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Shivam Kumar", role: "Co-coordinator", phone: "7667349750", email: "shivamk.dd24.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Abhinay", members: [
    TeamMember(name: "Anurag Kumar", role: "Coordinator", phone: "6203562428", email: "anuragk.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Tanya Bharti", role: "Co-coordinator", phone: "9835097452", email: "tanyab.ug24.ec@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Vistaakari", members: [
    TeamMember(name: "Ayush Kumar", role: "Coordinator", phone: "8271154570", email: "ayushkr1.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Vasu Choudhari", role: "Co-coordinator", phone: "8600550839", email: "vasuc.ug23.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Graphika", members: [
    TeamMember(name: "Nishant Kumar", role: "Coordinator", phone: "8866200955", email: "nishantk.ug23.ec@nitp.ac.in"),
    TeamMember(name: "Shourya Kumar", role: "Co-coordinator", phone: "7903385887", email: "kumarssh.ug24.cs@nitp.ac.in"),
    TeamMember(name: "Shubham Sinha", role: "Co-coordinator", phone: "8789806191", email: "shubhams.dd24.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Pratibimb", members: [
    TeamMember(name: "Palak Jaiswal", role: "Coordinator", phone: "9450081431", email: "palakj.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Nandani Awase", role: "Co-coordinator", phone: "6260248296", email: "nandania.ug23.cs@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Outdoor Sports", members: [
    TeamMember(name: "Aniket Jha", role: "Coordinator", phone: "9430045319", email: "aniketj.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Nikhil Kumar", role: "Co-coordinator", phone: "8603324409", email: "nikhilk.ug23.ec@nitp.ac.in"),
  ]),
  TeamCategory(teamName: "Indoor Sports", members: [
    TeamMember(name: "I. Chenchusasikanth Reddy", role: "Coordinator", phone: "9391529328", email: "ilupurur.ug23.cs@nitp.ac.in"),
    TeamMember(name: "Sai Keerthana Dulam", role: "Co-coordinator", phone: "9063932155", email: "dulamk.ug23.cs@nitp.ac.in"),
  ]),
];
// ==========================================
// MAIN UI WIDGET
// ==========================================
class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  // Toggle state
  String _currentCampus = 'Patna';

  @override
  Widget build(BuildContext context) {
    // Determine which dataset to show based on toggle
    List<TeamCategory> activeCoreTeam = _currentCampus == 'Patna' ? patnaCoreTeam : bihtaCoreTeam;
    List<TeamCategory> activeCommittees = _currentCampus == 'Patna' ? patnaCommittees : bihtaCommittees;
    List<TeamCategory> activeEventLeads = _currentCampus == 'Patna' ? patnaEventLeads : bihtaEventLeads;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.slate50,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.darkGrey, size: 20),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Meet The Team',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.darkGrey),
          ),
          centerTitle: true,
          // Bottom area holding both the Campus Toggle AND the TabBar
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(104), // Height for toggle + tabs
            child: Column(
              children: [
                _buildToggleSwitch(),
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.slate200.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      tabBarTheme: const TabBarThemeData(
                        overlayColor: WidgetStatePropertyAll(Colors.transparent),
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                      ),
                     ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryBlue,
                        boxShadow: [
                          BoxShadow(color: AppColors.primaryBlue.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))
                        ],
                      ),
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.slate600,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      tabs: const [
                        Tab(text: "Core Team"),
                        Tab(text: "Committees"),
                        Tab(text: "Event Leads"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _buildTeamList(activeCoreTeam),
              _buildTeamList(activeCommittees),
              _buildTeamList(activeEventLeads),
            ],
          ),
        ),
      ),
    );
  }

  // --- Campus Toggle Switch ---
  Widget _buildToggleSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.slate200.withOpacity(0.5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: ['Patna', 'Bihta'].map((campus) {
            bool isSelected = _currentCampus == campus;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentCampus = campus;
                  });
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
                    campus,
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

  // --- Team List Builder (Uses CustomScrollView to anchor footer) ---
  Widget _buildTeamList(List<TeamCategory> categories) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return _buildTeamCard(categories[index]);
              },
              childCount: categories.length,
            ),
          ),
        ),
        // This widget pushes the footer to the bottom of the screen
        // if the list content is small, but acts normally if the list is long.
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildHackSlashFooter(),
          ),
        ),
      ],
    );
  }

  // --- Individual Team Card ---
  Widget _buildTeamCard(TeamCategory category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.blue50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                const Icon(Icons.groups_rounded, size: 20, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.teamName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of Members
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: category.members.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _buildMemberRow(category.members[index]),
                  if (index < category.members.length - 1)
                    const Divider(height: 1, color: AppColors.slate200, indent: 16, endIndent: 16),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Member Row Item ---
  Widget _buildMemberRow(TeamMember member) {
    // Generate initials for avatar (e.g. "Aditya Raj" -> "AR")
    String initials = member.name.isNotEmpty
        ? member.name.trim().split(' ').map((e) => e.isNotEmpty ? e[0] : "").take(2).join()
        : "?";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Circular Initials Avatar
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.slate200,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.slate200),
            ),
            child: Center(
              child: Text(
                initials.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.slate500, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                ),
                const SizedBox(height: 2),
                Text(
                  member.role,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.slate500),
                ),
              ],
            ),
          ),

          // Action Buttons (Only visible if phone/email is available)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (member.phone != null && member.phone!.isNotEmpty)
                _buildActionButton(Icons.phone_outlined, Colors.green, () => _makePhoneCall(member.phone!)),

              if (member.email != null && member.email!.isNotEmpty) ...[
                if (member.phone != null && member.phone!.isNotEmpty) const SizedBox(width: 8),
                _buildActionButton(Icons.mail_outline_rounded, AppColors.primaryBlue, () => _sendEmail(member.email!)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  // --- HackSlash Footer ---
  Widget _buildHackSlashFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Designed & Developed by",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.slate400,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/image/img_1.png',
              //   height: 28,
              //   errorBuilder: (context, error, stackTrace) {
              //     return const SizedBox.shrink();
              //   },
              // ),
              const SizedBox(width: 8),
              const Text(
                "HackSlash Developers Club",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff00132b),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}