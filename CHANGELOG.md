## [2.1.3]
- Fixed toJson() call for ModelDetailedActivity (Thanks @tchex)

## [2.1.2]

- Updated web_auth into flutter_web_auth_2 (thanks to @ChrisElliotUK)
- Change unilinks dependency into app_links (thanks to @ChrisElliotUK)

## [2.1.1]

- Removed unnecessary print statement (thanks to @ChrisElliotUK)

## [2.1.0]

- Code cleanup and refactoring (thanks to @Nenuphar12) 
- Added Support for authenticate via native Strava app from ios if available
- Updated Readme.md for additional ios directives for native strava app authentication

## [2.0.3]
- First of all, Thanks a lot to all contributors. 
- [FIX] Issue #87 : Fails to auth on Android fix by @ChrisElliotUK
- [CHORE] Dependency cleanup @Nenuphar12 (thanks a lot)
- [FEATURE] Added PreferEphemeral pass through for auth by @withu-william
- [DOCUMENTATION] Improved code documentation by @Nenuphar12
- [FIX] updated dio package version by @dreampowder


## [2.0.0]
A Complete rewrite of the entire package. Thanks to https://www.github.com/birdyf for giving us a good headstart.
Warning, this version has no backwards compability and you have to re-implement everything. 

## [1.2.2+61]
Added getSegmentEffortById
Modification in AdroidManifest.xml to have authentication working with Firefox (not only Chrome)

## [1.2.1+51] 
Changed urlScheme from strava to stravaflutter used in url redirect to avoid conflict with strava app when installed in the mobile

## [1.2.0+45] 
Fix bug in _saveToken 


## [1.1.0+37] 
Fix user agent disallowed when selecting Google in Strava Auth page

## [1.0.12] 
Store the potentially new refresh token when getting new access token

## [1.0.11]  
 removed lines in test

## [1.0.10]  
added strava_prefix to preferences key

