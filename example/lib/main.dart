import 'package:example/examples/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:strava_flutter/domain/model/model_authentication_response.dart';
import 'package:strava_flutter/domain/model/model_authentication_scopes.dart';
import 'package:strava_flutter/strava_client.dart';
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

  void testAuthentication(){
    ExampleAuthentication(stravaClient)
        .testAuthentication([AuthenticationScope.profile_read_all,AuthenticationScope.read_all,AuthenticationScope.activity_read_all], "stravaflutter://redirect")
        .then((token){
        setState(() {
          isLoggedIn = true;
          this.token = token;
        });
        _textEditingController.text = token.accessToken;
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Strava Plugin")
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _login(),
          ],
        ),
      ),
    );
  }

  Widget _login(){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       ElevatedButton(child: Text("Login With Strava"),onPressed: testAuthentication,),
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
}
