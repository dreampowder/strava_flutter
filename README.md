# strava_flutter

Dart/flutter package to use Strava API v3

Follow the "new" Authentication process

https://developers.strava.com/docs/authentication/



API currently supported in addition to authentication process:
work in progress

- getLoggedInAthlete
- updateLoggedInAthlete (scope profile:write)
- getGearById
- getStats
- getClubById
- getClubActivitiesById (need to be member of the club)
- getClubMembersById (no need to be member of the club)
- getRunningRaces
- getRunningRaceById



How to use: 

Please check example() in main.dart for the moment

https://github.com/BirdyF/strava_flutter/blob/master/lib/main.dart


Tested on:
- Android 4.4.2 
- iOS 12.1.2


Problem found on iOS:

After Strava screen authentication not returning to app
because of know issue
https://github.com/flutter/flutter/issues/25721
You need to push OK button to get back to app


Thanks 

Thanks to Joe Birch, I used his code to better understand Oauth process
https://github.com/hitherejoe/FlutterOAuth

And Javier for https://javiercbk.github.io/json_to_dart/
