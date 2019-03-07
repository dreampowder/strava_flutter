// examples.dart

// Examples to use strava_flutter
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data'; // Needed when declaring ByteData


import 'package:strava_flutter/API/constants.dart';

// Used by uploadExample
import 'package:strava_flutter/API/strava.dart';
import 'package:strava_flutter/Models/fault.dart';
import 'package:strava_flutter/API/token.dart';




  /// Example showing how to upload an activity on Strava
  /// 
  /// Use file Bormes.gpx in assets
  /// 
  /// Should appear on your activities 6 Feb. 2018
  /// 
  /// Under the title Bormes3
  /// 
  Future<Fault> exampleUpload(String secret) async {

    Future<void> writeToFile(ByteData data, String path) {
      final buffer = data.buffer;
      return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    }

  

    // Do authentication with the right scope
    final strava = Strava(true, // To get display info in API
         secret);

    bool isAuthOk = false;

    isAuthOk = await strava.Oauth(clientId, 'activity:write', secret, 'auto');

    print('---> Authentication result: $isAuthOk');

    Token tokenStored = await strava.getStoredToken();
   

    // Use the asset file to test without having to create internally a ride
    //----------------------------------------------------------------------
    String dir = (await getApplicationDocumentsDirectory()).path;


    var data = await rootBundle.load('assets/Bormes.gpx');
    // Save the data loaded from the assert into a file
    // Transfer the data into a real file
    await writeToFile(data, '$dir/myActivity.gpx');

    Fault fault = await strava.uploadActivity('Bormes3', 'It is working!', '$dir/myActivity.gpx',
        'gpx', tokenStored.accessToken);

    return fault;
  }


