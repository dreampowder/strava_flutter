/// An enumeration of the types an activity may have.
///
/// Note that this enumeration does not include new sport types (e.g.
/// `MountainBikeRide`, `EMountainBikeRide`), activities with these sport types
/// will have the corresponding activity type (e.g. `Ride` for
/// `MountainBikeRide`, `EBikeRide` for `EMountainBikeRide`)
enum ActivityTypeEnum {
  undefined,
  AlpineSki,
  BackcountrySki,
  Canoeing,
  Crossfit,
  EBikeRide,
  Elliptical,
  Golf,
  Handcycle,
  Hike,
  IceSkate,
  InlineSkate,
  Kayaking,
  Kitesurf,
  NordicSki,
  Ride,
  RockClimbing,
  RollerSki,
  Rowing,
  Run,
  Sail,
  Skateboard,
  Snowboard,
  Snowshoe,
  Soccer,
  StairStepper,
  StandUpPaddling,
  Surfing,
  Swim,
  Velomobile,
  VirtualRide,
  VirtualRun,
  Walk,
  WeightTraining,
  Wheelchair,
  Windsurf,
  Workout,
  Yoga
}

extension ActivityTypeEnumHelper on ActivityTypeEnum {
  static ActivityTypeEnum getType(String value) {
    return ActivityTypeEnum.values.firstWhere(
        (element) => element.toString().endsWith(value),
        orElse: () => ActivityTypeEnum.undefined);
  }

  String stringValue() {
    return this.toString().split(".").last;
  }
}
