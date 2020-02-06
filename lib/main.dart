import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:js' as js;

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  print(kIsWeb);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: UrlChanger(),
        ),
      ),
    );
  }
}

class UrlChanger extends StatefulWidget {
  @override
  _UrlChangerState createState() => _UrlChangerState();
}

class _UrlChangerState extends State<UrlChanger> {
  String url;
  String newLocale = 'uk';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("URL: $url"),
      FlatButton(
        color: Colors.red,
        onPressed: () {
          var href = js.context['location']['href'];
          print('before push state: $href');
          js.context['history']
              .callMethod('pushState', [{}, '', '$href/google.com']);
          print('after pushstate');
          setState(() {
            url = js.context['location']['href'];
          });
        },
        child: Text(
            "Click me! I will add google.com at the end of URL! And then one more time!"),
      ),
      Text(
          'The issue is with history.pushState: in debug build it executes without errors and updates the url. In the release build it throws an exception!')
    ]);
  }
}
