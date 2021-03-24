import 'package:flutter/material.dart';
import 'package:reversi_app/src/pages/ai_vs_ai_page.dart';
import 'package:reversi_app/src/pages/player_vs_ai_page.dart';
import 'package:reversi_app/src/pages/player_vs_player_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(202, 240, 248, 1),
      body: Padding(
        padding: EdgeInsets.only(top: padding.top),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Title
            Align(
              alignment: Alignment.center,
              child: Text(
                'Reversi',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),



            Column(
              children: [
                Text(
                  'Select Mode:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),


                SizedBox(height: 20,),


                SizedBox(
                  width: size.width * 0.7,
                  height: 50,
                  child: OutlinedButton(
                    child: Text(
                      'player VS player',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.first == MaterialState.disabled) {
                          return Colors.transparent;
                        }
                        return Colors.deepOrange.withOpacity(0.5);
                      }),
                    ),
                    onPressed: () => this.goToPage(context, PlayerVsPlayerPage()),
                  ),
                ),


                SizedBox(height: 25),


                SizedBox(
                  width: size.width * 0.7,
                  height: 50,
                  child: OutlinedButton(
                    child: Text(
                      'player VS ai',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.first == MaterialState.disabled) {
                          return Colors.transparent;
                        }
                        return Colors.deepOrange.withOpacity(0.5);
                      }),
                    ),
                    onPressed: () => this.goToPage(context, PlayerVsAiPage()),
                  ),
                ),


                SizedBox(height: 25),


                SizedBox(
                  width: size.width * 0.7,
                  height: 50,
                  child: OutlinedButton(
                    child: Text(
                      'ai VS ai',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.first == MaterialState.disabled) {
                          return Colors.transparent;
                        }
                        return Colors.deepOrange.withOpacity(0.5);
                      }),
                    ),
                    onPressed: () => this.goToPage(context, AiVsAiPage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void goToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
  }
}
