import 'dart:math';
import 'dart:collection';
import 'package:spider/src/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:spider/src/viewmodel.dart';
import 'package:spider/src/animals/animals.dart';
import 'package:spider/src/model.dart' show Grid, Dashboard;

class GridViewModel extends ChangeNotifier {
  static Duration fastSpeed = const Duration(milliseconds: 200);
  static Duration slowSpeed = const Duration(milliseconds: 500);
  static Duration verySlowSpeed = const Duration(milliseconds: 1000);

  Duration delayDuration = slowSpeed;

  late Grid grid;
  late DashboardViewModel dashboard;

  Map<int, int> values = {};
  List<List<bool>> visited = [];
  List<int> inTesting = [];
  List<int> root = [];
  List<List<int>> heuristicMoves = [
    [0, 0],
    [0, 0]
  ];
  bool switchAlgorithms = false;
  bool isRunning = false;

  GridViewModel() {
    grid = Grid();
    visited = emptyVisitedList();
  }

  void speedUp() {
    if (delayDuration == slowSpeed) {
      delayDuration = fastSpeed;
    } else {
      delayDuration = slowSpeed;
    }
  }

  void clear() {
    isRunning = false;
    switchAlgorithms = false;
    grid = Grid();
    dashboard.clear();
    values = {};
    inTesting = [];
    root = [];
    heuristicMoves = [
      [0, 0],
      [0, 0]
    ];
    visited = emptyVisitedList();
    notifyListeners();
  }

  Color cellColor(int x, int y, Modes mode) {
    bool canSpiderReachNormal = grid.spider
        .getCanMoveLocations()
        .where((l) => l[0] == x && l[1] == y)
        .isNotEmpty;

    bool canSpiderReachHeuristic =
        heuristicMoves.where((l) => l[0] == x && l[1] == y).isNotEmpty;

    if (canSpiderReachNormal && mode == Modes.Normal) {
      return accent;
    } else if (canSpiderReachHeuristic &&
        (mode == Modes.H1 || mode == Modes.H2 || mode == Modes.H3)) {
      return accent;
    } else if (visited[x][y]) {
      return primary200;
    }
    return primary400;
  }

  List<List<bool>> emptyVisitedList() {
    return List.generate(
      maxX + 1,
      (i) => List.generate(maxY + 1, (j) => false),
    );
  }

  void setDashboard(BuildContext context) {
    dashboard = Provider.of<DashboardViewModel>(context, listen: false);
  }

  void run(Modes mode) async {
    if (isRunning) return;
    clear();
    if (mode == Modes.Normal) {
      return;
    } else if (mode == Modes.BFS) {
      isRunning = true;
      bfs();
    } else if (mode == Modes.DFS) {
      dfs();
    } else if (mode == Modes.A_STAR) {
      aStar();
    } else if (mode == Modes.H1) {
      while (!didGameFinished()) {
        await heuristicOne();
      }
    } else if (mode == Modes.H2) {
      while (!didGameFinished()) {
        await heuristicTwo();
      }
    } else if (mode == Modes.H3) {
      int antScore = dashboard.dashboard.antScore;
      int spiderScore = dashboard.dashboard.spiderScore;
      while (!didGameFinished()) {
        if (antScore != dashboard.dashboard.antScore ||
            spiderScore != dashboard.dashboard.spiderScore) {
          switchAlgorithms = false;
          antScore = dashboard.dashboard.antScore;
          spiderScore = dashboard.dashboard.spiderScore;
          heuristicMoves = [
            [0, 0],
            [0, 0]
          ];
        }
        if (switchAlgorithms) {
          await heuristicOne();
        } else {
          await heuristicTwo();
        }
      }
      switchAlgorithms = false;
    }
    isRunning = false;
    notifyListeners();
  }

  void bfs() async {
    bool firstMove = true;
    while (!didGameFinished()) {
      visited = emptyVisitedList();
      inTesting = [];
      root = [grid.spider.x, grid.spider.y];
      Queue<List<int>> q = Queue();
      notifyListeners();
      q.add(grid.spider.getLocation());
      while (q.isNotEmpty) {
        List<int> currentCell = q.first;
        q.removeFirst();
        if (visited[currentCell[0]][currentCell[1]]) continue;
        if (!firstMove) {
          move(currentCell[0], currentCell[1], moveWithoutCheck: true);
        }
        firstMove = false;
        visited[grid.spider.x][grid.spider.y] = true;
        notifyListeners();
        await delay();
        if (didSpiderEatAnt() || didGameFinished()) {
          await delay();
          break;
        }
        List<List<int>> canMoveLocations = grid.spider.getCanMoveLocations();
        for (List<int> canMoveLocation in canMoveLocations) {
          if (visited[canMoveLocation[0]][canMoveLocation[1]] == false) {
            q.add(canMoveLocation);
          }
        }
      }
    }
  }

  void dfs() async {
    bool firstMove = true;
    while (!didGameFinished()) {
      visited = emptyVisitedList();
      inTesting = [];
      Queue<List<int>> s = Queue();
      s.add(grid.spider.getLocation());
      while (s.isNotEmpty) {
        List<int> currentCell = s.last;
        s.removeLast();
        if (visited[currentCell[0]][currentCell[1]]) continue;
        if (!firstMove) {
          move(currentCell[0], currentCell[1], moveWithoutCheck: true);
        }
        firstMove = false;
        visited[grid.spider.x][grid.spider.y] = true;
        notifyListeners();
        await delay();
        if (didSpiderEatAnt() || didGameFinished()) {
          await delay();
          break;
        }
        List<List<int>> canMoveLocations = grid.spider.getCanMoveLocations();
        canMoveLocations = List.from(canMoveLocations.reversed);
        for (List<int> canMoveLocation in canMoveLocations) {
          if (visited[canMoveLocation[0]][canMoveLocation[1]] == false) {
            s.addLast(canMoveLocation);
          }
        }
      }
    }
  }

  void aStar() async {
    while (!didGameFinished()) {
      values = {};
      int currentDist = 1000;
      List<int> newLocation = [];
      List<List<int>> canMoveLocations = grid.spider.getCanMoveLocations();
      for (List<int> canMoveLocation in canMoveLocations) {
        List<int> testLocation = canMoveLocation;
        int _distToAnt = distToAnt(testLocation[0], testLocation[1]);
        values[testLocation[0] * maxX + testLocation[1]] = _distToAnt;
        notifyListeners();
        await delay();
        if (_distToAnt < currentDist) {
          currentDist = _distToAnt;
          newLocation = testLocation;
        }
      }
      move(newLocation[0], newLocation[1]);
      await delay();
    }
  }

  Future<void> heuristicOne() async {
    heuristicMoves = [
      [0, 0],
      [0, 0]
    ];
    List<List<int>> canMoveLocations = grid.spider.getCanMoveLocations(
      noBoundsCheck: true,
    );
    late int direction;
    if (grid.ant.x <= grid.spider.x && grid.ant.y <= grid.spider.y) {
      direction = 3;
    } else if (grid.ant.x >= grid.spider.x && grid.ant.y >= grid.spider.y) {
      direction = 1;
    } else if (grid.ant.x <= grid.spider.x && grid.ant.y >= grid.spider.y) {
      direction = 0;
    } else if (grid.ant.x >= grid.spider.x && grid.ant.y <= grid.spider.y) {
      direction = 2;
    } else {
      assert(false);
    }
    for (int i = 0; i < 2; i++) {
      int x = canMoveLocations[direction * 2 + i][0];
      int y = canMoveLocations[direction * 2 + i][1];
      if (Animal.isValidLocation(x, y)) {
        heuristicMoves[i] = [x, y];
      }
    }
    int rand = Random.secure().nextInt(heuristicMoves.length);
    if (heuristicMoves[rand][0] == 0) {
      canMoveLocations = grid.spider.getCanMoveLocations();
      rand = Random.secure().nextInt(canMoveLocations.length);
      heuristicMoves[0][0] = canMoveLocations[rand][0];
      heuristicMoves[0][1] = canMoveLocations[rand][1];
      rand = 0;
    }
    notifyListeners();
    await delay();
    move(heuristicMoves[rand][0], heuristicMoves[rand][1]);
    await delay();
  }

  Future<void> heuristicTwo() async {
    List<int> antEscapeLocation;
    if (grid.ant.movingDirection == 0) {
      antEscapeLocation = [grid.ant.x, maxX];
    } else {
      antEscapeLocation = [grid.ant.x, 1];
    }
    int distToGoal = (grid.spider.x - antEscapeLocation[0]).abs() +
        (grid.spider.y - antEscapeLocation[1]).abs();
    if (distToGoal < 3 && distToGoal > 0) {
      switchAlgorithms = true;
    }
    if (distToGoal == 0) switchAlgorithms = false;
    heuristicMoves[0] = antEscapeLocation;
    int currentDist = 1000;
    List<List<int>> canMoveLocations = grid.spider.getCanMoveLocations();
    List<int> newLocation = [];
    if ((grid.spider.x - antEscapeLocation[0]).abs() +
            (grid.spider.y - antEscapeLocation[1]).abs() ==
        0) {
      newLocation = [grid.spider.x, grid.spider.y];
    } else
      for (List<int> canMoveLocation in canMoveLocations) {
        List<int> testLocation = canMoveLocation;
        int _distToAnt = (testLocation[0] - antEscapeLocation[0]).abs() +
            (testLocation[1] - antEscapeLocation[1]).abs();
        if (_distToAnt < currentDist) {
          currentDist = _distToAnt;
          newLocation = testLocation;
        }
      }
    move(newLocation[0], newLocation[1], moveWithoutCheck: true);
    notifyListeners();
    await delay();
  }

  Future delay() async {
    await Future.delayed(delayDuration);
  }

  int distToAnt(int x, int y) {
    return (x - grid.ant.x).abs() + (y - grid.ant.y).abs();
  }

  bool didGameFinished() {
    return dashboard.spiderScore == Dashboard.maxScore ||
        dashboard.antScore == Dashboard.maxScore;
  }

  List<int> getAntLocation() {
    return [grid.ant.x, grid.ant.y];
  }

  List<int> getSpiderLocation() {
    return [grid.spider.x, grid.spider.y];
  }

  int getAntAngle() {
    final _possibleAngles = [90, 270];
    return _possibleAngles[grid.ant.movingDirection];
  }

  void move(int x, int y, {bool moveWithoutCheck = false}) async {
    if (dashboard.antScore == Dashboard.maxScore ||
        dashboard.spiderScore == Dashboard.maxScore) return;
    if (!canSpiderReach(x, y) && moveWithoutCheck == false) return;
    moveSpider(x, y);
    if (didSpiderEatAnt()) {
      dashboard.spiderGotScore();
      createNewAnt();
    } else {
      moveAnt();
      checkAntEscape();
    }
    notifyListeners();
  }

  void moveSpider(int x, int y) {
    grid.spider.move(x, y);
  }

  bool canSpiderReach(int x, int y) {
    final _location = [x, y];
    return grid.spider.canMoveLocations
        .where((l) => listEquals(l, _location))
        .isNotEmpty;
  }

  void moveAnt() {
    grid.ant.move();
    if (!isValidAntLocation()) {
      createNewAnt();
      dashboard.antGotPoint();
      return;
    }
    if (didSpiderEatAnt()) {
      dashboard.spiderGotScore();
      createNewAnt();
    }
  }

  void checkAntEscape() {
    if (!isValidAntLocation()) {
      createNewAnt();
    }
  }

  void createNewAnt() {
    grid.ant.setRandomLocation(grid.spider.x, grid.spider.y);
  }

  bool isValidAntLocation() {
    return Animal.isValidLocation(grid.ant.x, grid.ant.y);
  }

  bool isValidSpiderLocation(int x, int y) {
    return Animal.isValidLocation(x, y);
  }

  bool didSpiderEatAnt() {
    return grid.ant.x == grid.spider.x && grid.ant.y == grid.spider.y;
  }
}
