import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';
import 'package:spider/src/animals/animal.dart';

class Spider extends Animal {
  static Widget spiderIcon({double size = 24.0, Color color = primary100}) {
    return RotatedBox(
      quarterTurns: 2,
      child: Icon(
        Animals.spider,
        color: color,
        size: size,
      ),
    );
  }

  static List<int> dx = [-2, -1, 1, 2, 2, 1, -1, -2];
  static List<int> dy = [1, 2, 2, 1, -1, -2, -2, -1];
  static int numberOfDirections = 8;

  late List<List<int>> canMoveLocations;

  Spider(int x, int y) : super(x, y) {
    canMoveLocations = getCanMoveLocations();
  }

  void move(int x, int y) {
    this.x = x;
    this.y = y;
    canMoveLocations = getCanMoveLocations();
  }

  List<List<int>> getCanMoveLocations({bool noBoundsCheck = false}) {
    List<List<int>> _canMoveLocations = [];
    for (int i = 0; i < numberOfDirections; i++) {
      final reachedX = x + dx[i], reachedY = y + dy[i];
      if (Animal.isValidLocation(reachedX, reachedY) || noBoundsCheck) {
        _canMoveLocations.add([reachedX, reachedY]);
      }
    }
    return _canMoveLocations;
  }
}
