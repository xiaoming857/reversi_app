import 'dart:math';

import 'package:reversi_app/src/models/board.dart';


class MinMax {
  List<int> bestLocation;
  int index = 0;

  // int minmax(Board board, int depth, bool isMaximizing) {
  //   // Board newBoard= Board.fromBoard(board);
  //   // List<List<int>> possibleLocations = newBoard.findPossibleLocations(isMaximizing ? Disk.black : Disk.white);
  //   // if (possibleLocations.isNotEmpty) {
  //   //   int index = Random().nextInt(possibleLocations.length);
  //   //   print(possibleLocations[index]);
  //   //   return possibleLocations[index];
  //   // }
  //   // return null;
  //   if (depth == 0) {
  //     print('NANI ${index++}');
  //     print(board.toString());
  //     Map<Disk, int> info = board.getInfo();
  //     return info[Disk.black] - info[Disk.white];
  //   }
  //
  //
  //   List<List<int>> possibleLocations;
  //   if (isMaximizing) {
  //     Disk disk = Disk.black;
  //     possibleLocations = board.findPossibleLocations(disk);
  //     print(possibleLocations);
  //     if (possibleLocations.isNotEmpty) {
  //       List<int> values = [];
  //       for (List<int> location in possibleLocations) {
  //         Board newBoard = Board.fromBoard(board);
  //         newBoard.put(disk, location[0], location[1]);
  //         values.add(this.minmax(newBoard, depth - 1, !isMaximizing));
  //       }
  //       int bestValue = values.reduce(max);
  //       _setBestPosition(possibleLocations, values, bestValue, isMaximizing);
  //       return bestValue;
  //     }
  //   } else {
  //     Disk disk = Disk.white;
  //     possibleLocations = board.findPossibleLocations(disk);
  //     print(possibleLocations);
  //     if (possibleLocations.isNotEmpty) {
  //       List<int> values = [];
  //       for (List<int> location in possibleLocations) {
  //         Board newBoard = Board.fromBoard(board);
  //         newBoard.put(disk, location[0], location[1]);
  //         values.add(this.minmax(newBoard, depth - 1, !isMaximizing));
  //       }
  //       int bestValue = values.reduce(min);
  //       _setBestPosition(possibleLocations, values, bestValue, isMaximizing);
  //       return bestValue;
  //     }
  //   }
  // }


  /// The [minmax] method is used to find the best move, the move with highest value. Then [_setBestPosition] will be called.
  int minmax(Board board, int depth, bool isMaximizing) {
    if (depth == 0) {
      // print('NANI ${index++}');
      // print(board.toString());
      Map<Disk, int> info = board.getInfo();
      return info[Disk.black] - info[Disk.white];
    }
    int bestValue = isMaximizing ? -64 : 64;
    Disk disk = isMaximizing ? Disk.black : Disk.white;
    List<List<int>> possibleLocations = board.findPossibleLocations(disk);
    // print('POSSIBLE LOCATIONS: $possibleLocations');
    if (possibleLocations.isNotEmpty) {
      List<int> values = [];
      for (List<int> location in possibleLocations) {
        Board newBoard = Board.fromBoard(board);
        newBoard.put(disk, location[0], location[1]);
        values.add(this.minmax(newBoard, depth - 1, !isMaximizing));
      }
      bestValue = values.reduce((isMaximizing) ? max : min);
      _setBestPosition(possibleLocations, values, bestValue, isMaximizing);
    }
    return bestValue;
  }


  void _setBestPosition(List<List<int>> possibleLocations, List<int> values, int bestValue, bool isMaximizing) {
    List<List<int>> bestLocations = [];
    for (int i = 0; i < possibleLocations.length; i++) if (values[i] == bestValue) bestLocations.add(possibleLocations[i]);
    this.bestLocation = bestLocations[Random().nextInt(bestLocations.length)];
  }
}