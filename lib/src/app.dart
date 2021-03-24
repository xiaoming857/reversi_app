import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reversi_app/src/models/board.dart';
import 'package:reversi_app/src/models/min_max.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}


class _AppState extends State<App> {
  StreamController<Map<Disk, int>> winDialogController = StreamController<Map<Disk, int>>();
  final int boardSize = 8;
  Board board = Board();
  Disk diskTurn = Disk.black;
  List<List<int>> possibleLocations;


  @override
  void initState() {
    super.initState();
    this.possibleLocations = this.board.findPossibleLocations(this.diskTurn);
    this.winDialogController.stream.listen((Map<Disk, int>boardInfo) {
      String content = 'Draw!';
      if (boardInfo[Disk.black] > boardInfo[Disk.white]) content = 'Black Wins!';
      else content = 'White Wins!';

      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: Text('Game!'),
        content: Text(content),
        actions: [
          ElevatedButton(
            child: Text('Yay!'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ));
    });
  }


  @override
  void dispose() {
    super.dispose();
    this.winDialogController.close();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Map<Disk, int> boardInfo = this.board.getInfo();
    if (boardInfo[Disk.empty] == 0) this.winDialogController.add(boardInfo);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Reversi',
        ),

        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh_sharp
            ),

            onPressed: () {
              this.board = Board();
              this.diskTurn = Disk.black;
              this.possibleLocations = this.board.findPossibleLocations(this.diskTurn);
              setState(() {});
            }
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Text(
                  'Turn: ${(this.diskTurn == Disk.black) ? 'Black' : 'White'}',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${boardInfo[Disk.black]}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('Black Score'),
                      ],
                    ),


                    Column(
                      children: [
                        Text(
                          '${boardInfo[Disk.white]}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('White Score'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),


          Container(
            height: size.width,
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               for (int j = 0; j < this.boardSize; j++)
                 Expanded(
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       for (int i = 0; i < this.boardSize; i++)
                         Expanded(
                           child: Material(
                             shape: Border.all(
                               width: 0.5,
                               color: Colors.black38,
                             ),

                            color: Colors.lightGreen,
                             child: this._drawDisk(j, i),
                           ),
                         ),
                     ],
                   ),
                 ),
              ],
            ),
          ),


          Spacer(),


          if (this.possibleLocations.isEmpty && boardInfo[Disk.empty] != 0) SizedBox(
            height: 50,
            width: 100,
            child: ElevatedButton(
              child: Text(
                'Pass'
              ),

              onPressed: () {
                this.diskTurn = (this.diskTurn == Disk.black) ? Disk.white : Disk.black;
                this.possibleLocations = this.board.findPossibleLocations(this.diskTurn);
                setState(() {});
              },
            ),
          ),


          Spacer(),
        ],
      ),
    );
  }


  Widget _drawDisk(int j, int i) {
    Disk disk = this.board.inspect(j, i);
    bool isPossibleLocation = this.possibleLocations.any((e) => (e[0] == j && e[1] == i));
    if (disk == Disk.empty && !isPossibleLocation) {
      return SizedBox();
    }
    return InkWell(
      child: this._getIcon(disk),
      onTap: disk != Disk.empty ? null : () async {
        print('$j - $i');
        this.board.put(this.diskTurn, j, i);
        this.diskTurn = (this.diskTurn == Disk.black) ? Disk.white : Disk.black;
        this.possibleLocations = this.board.findPossibleLocations(this.diskTurn);
        setState(() {});

        await Future.delayed(Duration(seconds: 1));
        MinMax ai = MinMax();
        ai.minmax(board, 4, false);
        List<int> aiChoice = ai.bestLocation;
        if (aiChoice != null) {
          this.board.put(this.diskTurn, aiChoice[0], aiChoice[1]);
          this.diskTurn = (this.diskTurn == Disk.black) ? Disk.white : Disk.black;
          this.possibleLocations = this.board.findPossibleLocations(this.diskTurn);
        } else {
          this.diskTurn = (this.diskTurn == Disk.black) ? Disk.white : Disk.black;
          this.possibleLocations = this.board.findPossibleLocations(this.diskTurn);
        }
        setState(() {});
      },
    );
  }


  Widget _getIcon(Disk disk) {
    if (disk == Disk.black) {
      return Icon(
        Icons.circle,
        color: Colors.black,
      );
    } else if (disk == Disk.white) {
      return Icon(
        Icons.circle,
        color: Colors.white,
      );
    } else {
      return Icon(
        Icons.add_circle_outline,
        size: 16,
        color: Colors.black45,
      );
    }
  }
}
