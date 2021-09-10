class SegmentLeaderboard {
  int? effortCount;
  int? entryCount;
  String? komType;
  List<SegmentLeaderboardEntry>? entries;

  SegmentLeaderboard(
      {this.effortCount,
        this.entryCount,
        this.komType,
        this.entries});

  SegmentLeaderboard.fromJson(Map<String, dynamic> json) {
    effortCount = json['effort_count'];
    entryCount = json['entry_count'];
    komType = json['kom_type'];
    if (json['entries'] != null) {
      entries = <SegmentLeaderboardEntry>[];
      json['entries'].forEach((v) {
        entries?.add(SegmentLeaderboardEntry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['effort_count'] = this.effortCount;
    data['entry_count'] = this.entryCount;
    data['kom_type'] = this.komType;
    if (this.entries != null) {
      data['entries'] = this.entries?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SegmentLeaderboardEntry {
  String? athleteName;
  int? elapsedTime;
  int? movingTime;
  String? startDate;
  String? startDateLocal;
  int? rank;

  SegmentLeaderboardEntry(
      {this.athleteName,
        this.elapsedTime,
        this.movingTime,
        this.startDate,
        this.startDateLocal,
        this.rank});

  SegmentLeaderboardEntry.fromJson(Map<String, dynamic> json) {
    athleteName = json['athlete_name'];
    elapsedTime = json['elapsed_time'];
    movingTime = json['moving_time'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['athlete_name'] = this.athleteName;
    data['elapsed_time'] = this.elapsedTime;
    data['moving_time'] = this.movingTime;
    data['start_date'] = this.startDate;
    data['start_date_local'] = this.startDateLocal;
    data['rank'] = this.rank;
    return data;
  }
}