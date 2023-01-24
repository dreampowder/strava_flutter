import 'dart:async';

import 'package:example/examples/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:strava_client/domain/model/model_authentication_response.dart';
import 'package:strava_client/domain/model/model_authentication_scopes.dart';
import 'package:strava_client/domain/model/model_fault.dart';
import 'package:strava_client/strava_client.dart';
import 'secret.dart';
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
      home: StravaFlutterPage(),
    );
  }
}

class StravaFlutterPage extends StatefulWidget {

  @override
  _StravaFlutterPageState createState() => _StravaFlutterPageState();
}

class _StravaFlutterPageState extends State<StravaFlutterPage> {

  final TextEditingController _textEditingController = TextEditingController();
  final DateFormat dateFormatter = DateFormat("HH:mm:ss");
  late final StravaClient stravaClient;

  bool isLoggedIn = false;
  TokenResponse? token;

  @override
  void initState() {
    stravaClient = StravaClient(secret:secret,clientId:clientId);
    super.initState();
  }

  FutureOr<Null> showErrorMessage(dynamic error, dynamic stackTrace){
    if(error is Fault){

      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Did Receive Fault"),
          content: Text(
              "Message: ${error.message}\n-----------------\nErrors:\n${(error.errors ?? []).map((e) => "Code: ${e.code}\nResource: ${e.resource}\nField: ${e.field}\n").toList().join("\n----------\n")}"),
        );
      });
    }
  }

  void testAuthentication(){
    ExampleAuthentication(stravaClient)
        .testAuthentication([AuthenticationScope.profile_read_all,AuthenticationScope.read_all,AuthenticationScope.activity_read_all], "stravaflutter://redirect")
        .then((token){
        setState(() {
          isLoggedIn = true;
          this.token = token;
        });
        _textEditingController.text = token.accessToken;
    }).catchError(showErrorMessage);
  }

  void testDeauth(){
    ExampleAuthentication(stravaClient)
        .testDeauthorize()
        .then((value){
       setState(() {
         isLoggedIn = false;
         this.token = null;
         _textEditingController.clear();
       });
    }).catchError(showErrorMessage);
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Strava Plugin"),
        actions: [
          Icon(isLoggedIn ? Icons.radio_button_checked_outlined : Icons.radio_button_off, color: isLoggedIn ? Colors.white : Colors.red,),
          SizedBox(width: 8,)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _login(),
            _apiGroups()
          ],
        ),
      ),
    );
  }

  Widget _login(){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           ElevatedButton(child: Text("Login With Strava"),onPressed: testAuthentication,),
           ElevatedButton(child: Text("De Authorize"),onPressed: testDeauth,)
         ],
       ),
       SizedBox(height: 8,),
       TextField(
         minLines: 1,
         maxLines: 3,
         controller: _textEditingController,
         decoration: InputDecoration(
           border: OutlineInputBorder(),
           label: Text("Access Token"),
           suffixIcon: TextButton(child: Text("Copy"),onPressed: (){
             Clipboard.setData(ClipboardData(text: _textEditingController.text))
             .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied!"),)));
           },)
         ),
       ),
       Divider()
     ],
   );
  }

  Widget _apiGroups(){
    return IgnorePointer(
      ignoring: !isLoggedIn,
      child: AnimatedOpacity(
          opacity: isLoggedIn ? 1.0 : 0.4,
          duration: Duration(milliseconds: 200),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Athletes"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Clubs"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Gears"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Routes"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Running Races"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Segment Efforts"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Segments"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Streams"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Uploads"),
              trailing: Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }

}
