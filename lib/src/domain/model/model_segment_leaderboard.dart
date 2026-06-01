import 'package:json_annotation/json_annotation.dart';

part 'model_segment_leaderboard.g.dart';

@JsonSerializable()
class SegmentLeaderboard {
  @JsonKey(name: "effort_count")
  int? effortCount;
  @JsonKey(name: "entry_count")
  int? entryCount;
  @JsonKey(name: "kom_type")
  String? komType;
  @JsonKey(name: "entries")
  List<SegmentLeaderboardEntry>? entries;

  SegmentLeaderboard(
      {this.effortCount, this.entryCount, this.komType, this.entries});

  factory SegmentLeaderboard.fromJson(Map<String, dynamic> json) =>
      _$SegmentLeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentLeaderboardToJson(this);
}

@JsonSerializable()
class SegmentLeaderboardEntry {
  @JsonKey(name: "athlete_name")
  String? athleteName;
  @JsonKey(name: "elapsed_time")
  int? elapsedTime;
  @JsonKey(name: "moving_time")
  int? movingTime;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "start_date_local")
  String? startDateLocal;
  @JsonKey(name: "rank")
  int? rank;

  SegmentLeaderboardEntry(
      {this.athleteName,
      this.elapsedTime,
      this.movingTime,
      this.startDate,
      this.startDateLocal,
      this.rank});

  factory SegmentLeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$SegmentLeaderboardEntryFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentLeaderboardEntryToJson(this);
}
