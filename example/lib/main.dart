import 'package:flutter/material.dart';


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
    final strava = Strava(
      true,   // to get disply info in API
      secret, // Put your secret key in secret.dart file
    );
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

            
            Text(''),
            Text('Authentication'),
            Text('with strava_flutter Api'),
            RaisedButton(
              child: Text('strava_flutter'),
              onPressed: exampleStrava,
            ),
            Text(''),
            Text(''),
            Text('Upload with authentication'),
            RaisedButton(
              child: Text('upload'),
              onPressed: upload,
            ),
            Text(' '),
            Text(''),
            Text(''),
            Text('Push this button'),
            Text(
              'to revoke/DeAuthorize Strava user',
            ),
            
            RaisedButton(
              child: Text('DeAuthorize'),
              onPressed: deAuthorize,
            ),
          ],
        ),
      ),
    );
  }
}
