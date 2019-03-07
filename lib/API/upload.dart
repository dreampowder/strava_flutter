// Upload file

import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/fault.dart';
import '../Models/uploadActivity.dart';

abstract class Upload {
  Future<Fault> uploadActivity(String name, String description, String fileUrl,
      String fileType, String accessToken) async {
    print('Starting to upload activity');

    // To check if the activity has been uploaded successfully
    // No numeric error code for the moment given by Strava
    final String ready = "Your activity is ready.";
    final String deleted = "The created activity has been deleted.";
    final String error = "There was an error processing your activity.";
    final String processed = "Your activity is still being processed.";
    final String notFound = 'Not Found';

    final postUri = Uri.parse('https://www.strava.com/api/v3/uploads');
    StreamController<int> onUploadPending = StreamController();

    var fault = Fault(888, '');

    var request = http.MultipartRequest("POST", postUri);
    request.fields['data_type'] = fileType; // tested with gpx
    request.fields['trainer'] = 'false';
    request.fields['commute'] = 'false';
    request.fields['name'] = name;
    request.fields['external_id'] = 'strava_flutter';
    request.fields['description'] = description;

    Map<String, String> header = {'Authorization': 'Bearer $accessToken'};
    request.headers.addAll(header);

    request.files.add(await http.MultipartFile.fromPath('file', fileUrl));

    var response = await request.send();

    print('Response: ${response.statusCode} ${response.reasonPhrase}');

    fault.statusCode = response.statusCode;
    fault.message = response.reasonPhrase;

    if (response.statusCode != 201) {
      print('Error while uploading the activity');
      print('---> ${response.statusCode} - ${response.reasonPhrase}');
    }

    int idUpload;

    // Upload is processed by the server
    if (response.statusCode == 201) {
      print('---> Created');
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var _body = json.decode(value);
        ResponseUploadActivity _response =
            ResponseUploadActivity.fromJson(_body);

        print('id ${_response.id}');
        idUpload = _response.id;
        onUploadPending.add(idUpload);
      });

      String reqCheckUpgrade = 'https://www.strava.com/api/v3/uploads/';
      onUploadPending.stream.listen((id) async {
        reqCheckUpgrade = reqCheckUpgrade + id.toString();
        var resp = await http.get(reqCheckUpgrade, headers: header);
        print('check status ${resp.reasonPhrase}');

        if (resp.reasonPhrase == ready) {
          print('---> Activity succesfully uploaded');
          onUploadPending.close();
        }

        if ((resp.reasonPhrase == notFound) || (resp.reasonPhrase == error)) {
          print('---> Error while checking status upload');
          onUploadPending.close();
        }

        if (resp.reasonPhrase == deleted) {
          print('---> Activity deleted');
          onUploadPending.close();
        }

        if (resp.reasonPhrase == processed) {
          print('---> try another time');
          // wait 2 sec before checking again status
          Timer(Duration(seconds: 2), () => onUploadPending.add(id));
        }
      });
    }

    return fault;
  }
}
