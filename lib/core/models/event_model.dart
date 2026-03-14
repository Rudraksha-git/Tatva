class EventModel {
  String? id;
  bool? isActive;
  String? type;
  String? location;
  String? club;
  String? clubTagline;
  String? category;
  List<String>? tags;
  String? event;
  String? description;
  String? startDate;
  String? endDate;
  String? venue;
  TeamSize? teamSize;
  Schedule? schedule;
  bool? registrationOpen;
  String? rulebookUrl;
  List<String>? coordinator;

  EventModel({
    this.id,
    this.isActive,
    this.type,
    this.location,
    this.club,
    this.clubTagline,
    this.category,
    this.tags,
    this.event,
    this.description,
    this.startDate,
    this.endDate,
    this.venue,
    this.teamSize,
    this.schedule,
    this.registrationOpen,
    this.rulebookUrl,
    this.coordinator,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isActive = json['isActive'];
    type = json['type'];
    location = json['location'];
    club = json['club'];
    clubTagline = json['clubTagline'];
    category = json['category'];
    tags = json['tags'] != null ? List<String>.from(json['tags']) : [];
    event = json['event'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    venue = json['venue'];
    rulebookUrl = json['rulebookUrl'];
    teamSize = json['teamSize'] != null ? TeamSize.fromJson(json['teamSize']) : null;
    schedule = json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
    registrationOpen = json['registrationOpen'];
    coordinator = json['coordinator'] != null ? List<String>.from(json['coordinator']) : [];
  }
}

class TeamSize {
  int? min;
  int? max;
  TeamSize({this.min, this.max});
  TeamSize.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }
}

class Schedule {
  String? time;
  String? prelims;
  String? finals;
  Schedule({this.time, this.prelims, this.finals});
  Schedule.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    prelims = json['prelims'];
    finals = json['finals'];
  }
}