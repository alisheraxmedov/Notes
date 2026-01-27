class NoteModel {
  String title;
  String content;
  String date;
  String time; // Creation time
  String? nDate; // Notification Date
  String? nTime; // Notification Time
  String? today; // Modification date or sort key?

  NoteModel({
    required this.title,
    required this.content,
    required this.date,
    required this.time,
    this.nDate,
    this.nTime,
    this.today,
  });

  // From JSON (Map)
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      nDate: json['nDate'],
      nTime: json['nTime'],
      today: json['today'],
    );
  }

  // To JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "date": date,
      "time": time,
      if (nDate != null) "nDate": nDate,
      if (nTime != null) "nTime": nTime,
      if (today != null) "today": today,
    };
  }
}
