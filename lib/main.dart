import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reversi_app/src/app.dart';


void main() {
  runApp(Bootstrap());
}


class Bootstrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );


    return MaterialApp(
      title: 'Reversi App',
      home: App(),
    );
  }
}
