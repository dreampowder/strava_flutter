import 'package:flutter/material.dart';


import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'examples.dart';

import 'secret.dart'; // Store Strava app secret

import 'package:strava_flutter/API/strava.dart';


Strava strava;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strava Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StravaFlutterPage(title: 'strava_flutter demo'),
    );
  }
}

class StravaFlutterPage extends StatefulWidget {
  StravaFlutterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StravaFlutterPageState createState() => _StravaFlutterPageState();
}

class _StravaFlutterPageState extends State<StravaFlutterPage> {
  String clientID = "32212";
  final String redirectUrl = "http://localhost:8080";
  final String scope = 'profile:write';

  final strava = Strava(
    secret, // Put your secret key in secret.dart file
    'auto',  // Prompt strava login only when needed
  );

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  

  void exampleStrava() {

    example(secret);
  }


  void upload() {
    print('Trying to upload');

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    var fault = exampleUpload(secret);
  }

  void deAuthorize() async {
    // need to get authorized before (valid token)
    await strava.deAuthorize();
  }

  @override
  void dispose() {
    strava.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Working
            // Image.asset('assets/test.JPG'),

            Text('Push this button'),
            Text(
              'to revoke/DeAuthorize Strava user',
            ),
            Text(''),
            RaisedButton(
              child: Text('DeAuthorize'),
              onPressed: deAuthorize,
            ),
            Text('Push this button to start'),
            Text(
              'the Strava authentication',
            ),
            Text(
              'using basic example',
            ),
            Text(''),
            Text('Authentication'),
            Text('with strava_flutter Api'),
            RaisedButton(
              child: Text('strava_flutter'),
              onPressed: exampleStrava,
            ),
            Text(''),
            Text('Upload with authentication'),
            RaisedButton(
              child: Text('upload'),
              onPressed: upload,
            ),
          ],
        ),
      ),
    );
  }
}
