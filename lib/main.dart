import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reversi_app/src/app.dart';


// TODO: Change win/loss condition to either all the disk become same color or no more empty space on board.
// TODO: Refactor & rename
// TODO: Improve position points
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
