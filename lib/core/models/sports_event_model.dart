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
  String? posterUrl;
  List<String>? coordinator;
  List<String>? coCoordinator;

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
    this.endDate,
    this.venue,
    this.registrationOpen,
    this.rulebookUrl,
    this.posterUrl,
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
    rulebookUrl = json['rulebookUrl'];
    posterUrl = json['posterUrl'];

    // Safely handle null arrays
    coordinator = json['coordinator'] != null ? List<String>.from(json['coordinator']) : [];
    coCoordinator = json['coCoordinator'] != null ? List<String>.from(json['coCoordinator']) : [];
  }
}