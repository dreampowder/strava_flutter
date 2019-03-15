# strava_flutter

Dart/flutter package to use Strava API v3

Follow the "new" Authentication process

https://developers.strava.com/docs/authentication/



## API currently supported:

- authorize
- deauthorize



- getLoggedInAthlete
- updateLoggedInAthlete (scope profile:write)
- getGearById
- getStats
- getClubById
- getClubActivitiesById (need to be member of the club)
- getClubMembersById (no need to be member of the club)
- getRunningRaces
- getRunningRaceById
- uploadActivity (including getUploadById)




## How to use it

1 - Create a file secret.dart to put the secret shown on  Strava settings related to your app
https://www.strava.com/settings/api

2 - In constants.dart put your appID in clientID

3 - To see debug info in Strava API, set isInDebug to true in globals.dart

4 - Please check examples.dart for the moment

https://github.com/BirdyF/strava_flutter/blob/master/example/lib/main.dart

https://github.com/BirdyF/strava_flutter/blob/master/example/lib/examples.dart


If you have any problem and need an API not yet implemented please post an new issue


## Tested on:
- Android 4.4.2 , 4.4.23
- iOS 12.1.2


## Problem found on iOS:

After Strava screen authentication not returning to app
because of know issue
https://github.com/flutter/flutter/issues/25721
You need to push OK button to get back to app


## Thanks 

Thanks to Joe Birch, I used his code to better understand Oauth process
https://github.com/hitherejoe/FlutterOAuth

And Javier for https://javiercbk.github.io/json_to_dart/


## License:
strava_flutter is provided under a MIT License. Copyright (c) 2019 Patrick FINK
