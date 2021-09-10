class SegmentLeaderboardRequest{
  SegmentDateRange dateRange;
  SegmentGender gender;
  SegmentAgeGroup ageGroup;
  SegmentWeightClass weightClass;
  int segmentId;
  int clubId;
  int maxEntries;
  bool isFollowing;
  int page;
  int perPage;
  SegmentLeaderboardRequest(
      this.dateRange,
      this.gender,
      this.ageGroup,
      this.weightClass,
      this.segmentId,
      this.clubId,
      this.maxEntries,
      this.isFollowing,
      this.page,
      this.perPage
      );

  Map<String,dynamic> toJson()=>{
    "gender":gender.toString().replaceAll("SegmentGender.", ""),
    "age_group":ageGroup.toString().replaceAll("SegmentAgeGroup.AgeGroup_", ""),
    "weight_class":weightClass.toString().replaceAll("SegmentWeightClass_WeightClass_", ""),
    "following":isFollowing ? "true" : "false",
    "club_id":clubId,
    "data_range":dateRange.toString().replaceAll("SegmentDateRange.", ""),
    "context_entries":"",
    "page":page,
    "per_page":perPage
  };
}

// String reqLeaderboard = 'https://www.strava.com/api/v3/segments/' +
//     id.toString() +
//     '/leaderboard?=gender' +
//     gender +
//     '&age_group=' +
//     ageGroup +
//     '&weight_class=' +
//     weightclass +
//     '&following=' +
//     following.toString() +
//     '&club_id=' +
//     clubIdStr +
//     '&date_range=' +
//     dateRange +
//     '&context_entries=' +
//     '&page=$_pageNumber&per_page=$_perPage';

enum SegmentGender{
  male, female
}

enum SegmentAgeGroup{
  AgeGroup_0_19,
  AgeGroup_20_24,
  AgeGroup_25_34,
  AgeGroup_35_44,
  AgeGroup_45_54,
  AgeGroup_55_64,
  AgeGroup_65_69,
  AgeGroup_70_74,
  AgeGroup_75_plus
}

enum SegmentWeightClass{
  WeightClass_0_124,
  WeightClass_125_149,
  WeightClass_150_164,
  WeightClass_165_179,
  WeightClass_180_199,
  WeightClass_200_224,
  WeightClass_225_249,
  WeightClass_250_plus,
  WeightClass_0_54,
  WeightClass_55_64,
  WeightClass_65_74,
  WeightClass_75_84,
  WeightClass_85_94,
  WeightClass_95_104,
  WeightClass_105_114,
  WeightClass_115_plus
}

enum SegmentDateRange{
  this_year, this_month, this_week, today
}