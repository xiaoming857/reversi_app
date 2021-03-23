enum Disk {
  black,
  white,
  empty,
}


class Board {
  static const defaultBoardSize = 8;
  List<List<Disk>> _board = [];


  Map<Disk, int> getInfo() {
    int blackNum = 0;
    int whiteNum = 0;
    int emptyNum = 0;

    this._board.forEach((row) {
      blackNum += row.where((disk) => disk == Disk.black).length;
    });

    this._board.forEach((row) {
      whiteNum += row.where((disk) => disk == Disk.white).length;
    });

    emptyNum = defaultBoardSize * defaultBoardSize - blackNum - whiteNum;
    return {
      Disk.black: blackNum,
      Disk.white: whiteNum,
      Disk.empty: emptyNum,
    };
  }


  Board() {
    this._board = [];
    for (int j = 0; j < defaultBoardSize; j++) {
      _board.add(List.filled(defaultBoardSize, Disk.empty));
    }

    final int centerPoint = defaultBoardSize ~/ 2 - 1;
    this._board[centerPoint][centerPoint] = Disk.black;
    this._board[centerPoint][centerPoint + 1] = Disk.white;
    this._board[centerPoint + 1][centerPoint] = Disk.white;
    this._board[centerPoint + 1][centerPoint + 1] = Disk.black;
  }


  Board.fromBoard(Board board) {
    this._board = [];
    board._board.forEach((row) {
      this._board.add(List.from(row));
    });
  }


  Disk inspect(int y, int x) => this._board[y][x];


  List<List<int>> findPossibleLocations(Disk disk) {
    Disk oppositeDisk = (disk == Disk.black) ? Disk.white : Disk.black;
    List<List<int>> possibleLocations = [];
    for (int y = 0; y < defaultBoardSize; y++) {
      for (int x = 0; x < defaultBoardSize; x++) {
        if (this._board[y][x] == disk) {
          int j = 0; int i = 0;

          //Top
          j = y - 1; i = x;
          while (j >= 0 && this._board[j][i] == oppositeDisk) {
            if (j - 1 >= 0 && this._board[j - 1][i] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j-1 && location[1] == i)) possibleLocations.add([j - 1, i]);
              break;
            }
            j--;
          }

          //Bottom
          j = y + 1; i = x;
          while (j < defaultBoardSize && this._board[j][i] == oppositeDisk) {
            if (j + 1 < defaultBoardSize && this._board[j + 1][i] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j+1 && location[1] == i)) possibleLocations.add([j + 1, i]);
              break;
            }
            j++;
          }

          //Left
          j = y; i = x - 1;
          while (i >= 0 && this._board[j][i] == oppositeDisk) {
            if (i - 1 >= 0 && this._board[j][i - 1] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j && location[1] == i-1)) possibleLocations.add([j, i - 1]);
              break;
            }
            i--;
          }


          //Right
          j = y; i = x + 1;
          while (i < defaultBoardSize && this._board[j][i] == oppositeDisk) {
            if (i + 1 < defaultBoardSize && this._board[j][i + 1] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j && location[1] == i+1)) possibleLocations.add([j, i + 1]);
              break;
            }
            i++;
          }


          //Top Left
          j = y - 1; i = x - 1;
          while (j >= 0 && i >= 0 && this._board[j][i] == oppositeDisk) {
            if (j - 1 >= 0 && i - 1 >= 0 && this._board[j - 1][i - 1] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j-1 && location[1] == i-1)) possibleLocations.add([j - 1, i - 1]);
              break;
            }
            j--;
            i--;
          }


          //Top Right
          j = y - 1; i = x + 1;
          while (j >= 0 && i < defaultBoardSize && this._board[j][i] == oppositeDisk) {
            if (j - 1 >= 0 && i + 1 < defaultBoardSize && this._board[j - 1][i + 1] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j-1 && location[1] == i+1)) possibleLocations.add([j - 1, i + 1]);
              break;
            }
            j--;
            i++;
          }


          //Bottom Right
          j = y + 1; i = x + 1;
          while (j < defaultBoardSize && i < defaultBoardSize && this._board[j][i] == oppositeDisk) {
            if (j + 1 < defaultBoardSize && i + 1 < defaultBoardSize && this._board[j + 1][i + 1] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j+1 && location[1] == i+1)) possibleLocations.add([j + 1, i + 1]);
              break;
            }
            j++;
            i++;
          }

          //Bottom Left
          j = y + 1; i = x - 1;
          while (j < defaultBoardSize && i >= 0 && this._board[j][i] == oppositeDisk) {
            if (j + 1 < defaultBoardSize && i - 1 >= 0 && this._board[j + 1][i - 1] == Disk.empty) {
              if (!possibleLocations.any((List<int> location) => location[0] == j+1 && location[1] == i-1)) possibleLocations.add([j + 1, i - 1]);
              break;
            }
            j++;
            i--;
          }
        }
      }
    }
    return possibleLocations;
  }


  void put(Disk disk, int y, int x) {
    if (this._board[y][x] == Disk.empty) this._board[y][x] = disk;
    this._reverse(disk, y, x);
  }


  void _reverse(Disk disk, int y, int x) {
    int j; int i;


    //Top
    j = y - 1; i = x;
    while (j >= 0 && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        j++;
        while (j < y) {
          this._board[j][i] = disk;
          j++;
        }
        break;
      }
      j--;
    }


    //Bottom
    j = y + 1; i = x;
    while (j < defaultBoardSize && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        j--;
        while (j > y) {
          this._board[j][i] = disk;
          j--;
        }
        break;
      }
      j++;
    }


    //Left
    j = y; i = x - 1;
    while (i >= 0 && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        i++;
        while (i < x) {
          this._board[j][i] = disk;
          i++;
        }
        break;
      }
      i--;
    }


    //Right
    j = y; i = x + 1;
    while (i < defaultBoardSize && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        i--;
        while (i > x) {
          this._board[j][i] = disk;
          i--;
        }
        break;
      }
      i++;
    }


    //Top Left
    j = y - 1; i = x - 1;
    while (j >= 0 && i >= 0 && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        j++; i++;
        while (j < y && i < x) {
          this._board[j][i] = disk;
          j++; i++;
        }
        break;
      }
      j--;
      i--;
    }


    //Top Right
    j = y - 1; i = x + 1;
    while (j >= 0 && i < defaultBoardSize && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        j++; i--;
        while (j < y && i > x) {
          this._board[j][i] = disk;
          j++; i--;
        }
        break;
      }
      j--;
      i++;
    }


    //Bottom Right
    j = y + 1; i = x + 1;
    while (j < defaultBoardSize && i < defaultBoardSize && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        j--; i--;
        while (j > y && i > x) {
          this._board[j][i] = disk;
          j--; i--;
        }
        break;
      }
      j++; i++;
    }


    //Bottom Left
    j = y + 1; i = x - 1;
    while (j < defaultBoardSize && i >= 0 && this._board[j][i] != Disk.empty) {
      if (this._board[j][i] == disk) {
        j--; i++;
        while (j > y && i < x) {
          this._board[j][i] = disk;
          j--; i++;
        }
        break;
      }
      j++; i--;
    }
  }


  @override
  String toString() {
    String str = '';
    this._board.forEach((rows) {
      rows.forEach((Disk disk) {
        if (disk == Disk.black) {
          str += 'X ';
        } else if (disk == Disk.white) {
          str += 'O ';
        } else {
          str += '- ';
        }
      });
      str += '\n';
    });
    return str;
  }
}