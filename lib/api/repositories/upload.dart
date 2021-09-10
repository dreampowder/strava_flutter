// Upload file

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:strava_flutter/error_codes.dart' as error;
import 'package:strava_flutter/globals.dart' as globals;
import 'package:strava_flutter/models/fault.dart';
import 'package:strava_flutter/models/upload_activity.dart';

abstract class Upload {
  /// Tested with gpx and tcx
  /// For the moment the parameters
  ///
  /// trainer and commute are set to false
  ///
  /// statusCode:
  /// 201 activity created
  /// 400 problem could be that activity already uploaded
  ///
  Future<Fault> uploadActivity(
    String? name,
    String? description,
    String? fileUrl,
    String? fileType,
  ) async {
    globals.displayInfo('Starting to upload activity');

    // To check if the activity has been uploaded successfully
    // No numeric error code for the moment given by Strava
    final String ready = "Your activity is ready.";
    final String deleted = "The created activity has been deleted.";
    final String errorMsg = "There was an error processing your activity.";
    final String processed = "Your activity is still being processed.";
    final String notFound = 'Not Found';

    final postUri = Uri.parse('https://www.strava.com/api/v3/uploads');
    StreamController<int?> onUploadPending = StreamController();

    Fault fault = Fault(888, '');

    final request = http.MultipartRequest("POST", postUri);
    if (fileType != null) request.fields['data_type'] = fileType; // tested with gpx
    request.fields['trainer'] = 'false';
    request.fields['commute'] = 'false';
    if (name != null) request.fields['name'] = name;
    request.fields['external_id'] = 'strava_flutter';
    if (description != null) request.fields['description'] = description;

    final _header = globals.createHeader();

    if (_header.containsKey('88') == true) {
      globals.displayInfo('Token not yet known');
      fault = Fault(error.statusTokenNotKnownYet, 'Token not yet known');
      return fault;
    }

    request.headers.addAll(_header);

    if (fileUrl != null)
      request.files.add(
        await http.MultipartFile.fromPath('file', fileUrl),
      );
    globals.displayInfo(request.toString());

    final response = await request.send();

    globals.displayInfo('Response: ${response.statusCode} ${response.reasonPhrase}');

    fault.statusCode = response.statusCode;
    fault.message = response.reasonPhrase;

    if (response.statusCode != 201) {
      globals.displayInfo('Error while uploading the activity');
      globals.displayInfo('${response.statusCode} - ${response.reasonPhrase}');
    }

    int? idUpload;

    // Upload is processed by the server
    // now wait for the upload to be finished
    //----------------------------------------
    if (response.statusCode == 201) {
      globals.displayInfo('Activity successfully created');
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        final Map<String, dynamic> _body = json.decode(value);
        ResponseUploadActivity _response = ResponseUploadActivity.fromJson(_body);

        print('id ${_response.id}');
        idUpload = _response.id;
        onUploadPending.add(idUpload);
      });

      String reqCheckUpgrade = 'https://www.strava.com/api/v3/uploads/';
      onUploadPending.stream.listen((id) async {
        reqCheckUpgrade = reqCheckUpgrade + id.toString();
        final resp = await http.get(Uri.parse(reqCheckUpgrade), headers: _header);
        print('check status ${resp.reasonPhrase}  ${resp.statusCode}');

        // Everything is fine the file has been loaded
        if (resp.statusCode == 200) {
          print('200 ${resp.reasonPhrase}');
        }

        // 404 the temp id does not exist anymore
        // Activity has been probably already loaded
        if (resp.statusCode == 404) {
          print('---> 404 activity already loaded  ${resp.reasonPhrase}');
        }

        if (resp.reasonPhrase?.compareTo(ready) == 0) {
          print('---> Activity succesfully uploaded');
          onUploadPending.close();
        }

        if ((resp.reasonPhrase?.compareTo(notFound) == 0) ||
            (resp.reasonPhrase?.compareTo(errorMsg) == 0)) {
          print('---> Error while checking status upload');
          onUploadPending.close();
        }

        if (resp.reasonPhrase?.compareTo(deleted) == 0) {
          print('---> Activity deleted');
          onUploadPending.close();
        }

        if (resp.reasonPhrase?.compareTo(processed) == 0) {
          print('---> try another time');
          // wait 2 sec before checking again status
          Timer(Duration(seconds: 2), () => onUploadPending.add(id));
        }
      });
    }

    return fault;
  }
}
