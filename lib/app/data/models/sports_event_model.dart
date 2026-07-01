class SportsEventModel {
  String? id;
  bool? isActive;
  String? type;
  String? location;
  String? sport;
  String? tagline;
  String? description;
  List<String>? format;
  String? startDate;
  String? endDate;
  String? venue;
  bool? registrationOpen;
  String? rulebookUrl;
  String? registrationUrl;
  String? posterUrl;
  List<String>? coordinator;
  List<String>? coCoordinator;
  List<String>? contactMain;
  List<String>? contactSub;

  SportsEventModel({
    this.id,
    this.isActive,
    this.type,
    this.location,
    this.sport,
    this.tagline,
    this.description,
    this.format,
    this.startDate,
    this.registrationUrl,
    this.endDate,
    this.venue,
    this.registrationOpen,
    this.rulebookUrl,
    this.posterUrl,
    this.contactMain,
    this.contactSub,
    this.coordinator,
    this.coCoordinator,
  });

  SportsEventModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isActive = json['isActive'];
    type = json['type'];
    location = json['location'];
    sport = json['sport'];
    tagline = json['tagline'];
    description = json['description'];
    format = json['format'] != null ? List<String>.from(json['format']) : [];
    startDate = json['startDate'];
    endDate = json['endDate'];
    venue = json['venue'];
    registrationOpen = json['registrationOpen'];
    registrationUrl = json['registrationUrl'];
    rulebookUrl = json['rulebookUrl'];
    posterUrl = json['posterUrl'];

    // Safely handle null arrays
    coordinator = json['coordinator'] is List
        ? List<String>.from(json['coordinator'])
        : (json['coordinator'] is String && json['coordinator'].isNotEmpty
            ? [json['coordinator']]
            : []);
    coCoordinator = json['coCoordinator'] is List
        ? List<String>.from(json['coCoordinator'])
        : (json['coCoordinator'] is String && json['coCoordinator'].isNotEmpty
            ? [json['coCoordinator']]
            : []);
    contactMain = json['contactMain'] is List
        ? List<String>.from(json['contactMain'])
        : (json['contactMain'] is String && json['contactMain'].isNotEmpty
            ? [json['contactMain']]
            : []);
    contactSub = json['contactSub'] is List
        ? List<String>.from(json['contactSub'])
        : (json['contactSub'] is String && json['contactSub'].isNotEmpty
            ? [json['contactSub']]
            : []);
  }
}