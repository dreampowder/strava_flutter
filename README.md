# strava_flutter

Dart/flutter package to use Strava API v3

Follow the "new" Authentication process

https://developers.strava.com/docs/authentication/



## API currently supported:

### Authentication
- authorize
- deauthorize

### Athlete related APIs
- getLoggedInAthlete
- updateLoggedInAthlete (scope profile:write)
- getLoggedInAthleteActivities (not limited)
- getLoggedInAthleteZones
- getGearById
- getStats 
### Club related APIs
- getClubById
- getClubActivitiesById 
- getClubMembersById 
### Race related APIs
- getRunningRaces
- getRunningRaceById
### Activity related APIs
- createActivity
- uploadActivity (includes getUploadById)
### Segments related APIs
- getSegmentById
- getLoggedInAthleteStarredSegments
- getLeaderboardBySegmentId (only 50 athletes for the moment)




## How to use it

1 - Create a file secret.dart to put the secret shown on  Strava settings related to your app
https://www.strava.com/settings/api

2 - In constants.dart put your appID in clientID

3 - To see debug info in Strava API, set isInDebug to true in Strava() init

4 - Please check examples.dart for the moment

https://github.com/BirdyF/strava_flutter/blob/master/example/lib/main.dart

https://github.com/BirdyF/strava_flutter/blob/master/example/lib/examples.dart


If you have any problem or need an API not yet implemented please post a new issue


## Tested on:
- Android 4.4.2 , 4.4.23
- iOS 12.1, 12.1.2, 12.1.4


## Contributors welcome!
If you spot a problem/bug or if you consider that the code could be better please post an issue.
I am not planning to implement all the Strava APIs, because I dont need all of them in my dev.
But let me know if you need some APIs that are in the current list and I will add it.
Alternatively, you can easily implement additional API and I will add it to strava_futter.


## Thanks 

Thanks to Joe Birch, I used his code to better understand Oauth process
https://github.com/hitherejoe/FlutterOAuth

And Javier for https://javiercbk.github.io/json_to_dart/


## License:
strava_flutter is provided under a MIT License. Copyright (c) 2019 Patrick FINKELSTEIN
