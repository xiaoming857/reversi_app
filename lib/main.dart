import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reversi_app/src/app.dart';


// TODO: Handle AI if there is no possible move (PASS) - (Empty possible locations list)
// TODO: Change win/loss condition to either all the disk become same color or no more empty space on board.
// TODO: Refactor & rename
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
