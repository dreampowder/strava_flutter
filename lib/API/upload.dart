// Upload file

// Not working yet
// In tests
import 'dart:async';
import 'dart:io';
import 'dart:typed_data'; // Needed when declaring ByteData
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


import 'constants.dart';
import '../Models/uploadActivity.dart';
import 'strava.dart';  // To remove when removing test1 and test2

// To check if the activity has been uploaded successfully
// No numeric error code for the moment given by Strava
class StatusUpload {
        String ready = "Your activity is ready.";
        String deleted = "The created activity has been deleted.";
        String error = "There was an error processing your activity.";
        String processed = "Your activity is still being processed.";
        String notFound = 'Not Found';
        
}  // End of enum statusUpload
    


abstract class Upload {


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.rtf');
  }

  Future<File> writeFile(String text) async {
    final file = await _localFile;
    return file.writeAsString('$text\r\n', mode: FileMode.append);
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      print('error $e');
      return 'Errror';
    }
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<Fault> uploadActivity(String name, String description, String fileUrl,
      String fileType, String accessToken) async {
    final postUri = Uri.parse('https://www.strava.com/api/v3/uploads');

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

    String _body = '';

    var response = await request.send();

    // request.send().then((response) {
      print('Response: ${response.statusCode} ${response.reasonPhrase}');

      fault.statusCode =response.statusCode;
      fault.message =response.reasonPhrase;

      if (response.statusCode == 201) {
        print('Created!!!');
      } else {
        print('Error while uploading the activity');
        print('---> ${response.reasonPhrase}');

      }

    int idUpload;

    // Upload is processed by the server
    if (fault.statusCode == 201) {

      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var _body = json.decode(value);
        ResponseUploadActivity _response = ResponseUploadActivity.fromJson(_body);

        print('id ${_response.id}');
        idUpload =_response.id;

      });


      // Todo: Every second or two check if upload has been susccesful
 
      final reqCheckUpgrade = 'https://www.strava.com/api/v3/uploads/' + idUpload.toString();
      
      var resp =  await http.get(reqCheckUpgrade, headers: header);
      print('check status ${resp.reasonPhrase}');
      


    }
    
    return fault;


  }




  //// test2()
  /// This is a test function 
  /// to debug Strava upload activity
  void test2(String secret) async {
    // Do an authentication with the right scope
    final strava = Strava(
        "32212", secret, "http://localhost:8080", 'auto', 'activity:write');

    await strava.OAuth("32212", "http://localhost:8080", 'activity:write', secret);
    var _token = await strava.getStoredToken();

    // Use the asset file to test without having to create internally a ride
    //----------------------------------------------------------------------
    String dir = (await getApplicationDocumentsDirectory()).path;
    var data = await rootBundle.load('assets/Bormes.gpx');
    // Save the data loaded from the assert into a file
    // Transfer the data into a real file
    await writeToFile(data, '$dir/myActivity.gpx');

    uploadActivity('Bormes3', 'It is working!', '$dir/myActivity.gpx', 'gpx',
        _token.accessToken);

    // Need to get the activity ID to poll and check the activity has been uploaded
  }

  void test1(String secret) async {
    print('this is our first test to manage files using Flutter');

    var text = await readFile();
    print('text ?? $text');

    String dir = (await getApplicationDocumentsDirectory()).path;

    var newFile = File('$dir/tototo.txt');
    newFile.writeAsStringSync('HeeHaa!', mode: FileMode.append);

    var result = newFile.readAsStringSync().toString();
    print(newFile.lengthSync());
    print(result);

    // var data = await rootBundle.load('assets/test.JPG');
    var data = await rootBundle.load('assets/Bormes.gpx');

    // Save the data loaded from the assert into a file
    await writeToFile(data, '$dir/myActivity.gpx');

    var newAct = File('$dir/myActivity.gpx');
    print(newAct.lengthSync());


    final strava = Strava(
        "32212", secret, "http://localhost:8080", 'auto', 'activity:write');
  
    strava.OAuth("32212", "http://localhost:8080", 'activity:write', secret);

    final postUri = Uri.parse('https://www.strava.com/api/v3/uploads');
    final fileUrl = '$dir/myActivity.gpx';

    var request = http.MultipartRequest("POST", postUri);
    request.fields['data_type'] = 'gpx';
    request.fields['trainer'] = 'false';
    request.fields['commute'] = 'false';
    request.fields['name'] = 'Bormes2';
    request.fields['external_id'] = 'Bormes2';
    request.fields['description'] = 'same activity';

    var token = await strava.getStoredToken();
    print('accessToken ${token.accessToken}');

    Map<String, String> header = {
      'Authorization': 'Bearer ${token.accessToken}'
    };
    request.headers.addAll(header);

    request.files.add(await http.MultipartFile.fromPath('file', fileUrl));

    request.send().then((response) {
      print('status ${response.statusCode}');
      if (response.statusCode == 201) {
        // UploadActivity _upload = UploadActivity.fromJson(json.decode(response.stream);
      }
    });


  }
}
