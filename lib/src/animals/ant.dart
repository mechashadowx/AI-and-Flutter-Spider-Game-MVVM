import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';
import 'package:spider/src/animals/animal.dart';

class Ant extends Animal {
  static Widget antIcon({double size = 24.0, Color color = primary100}) {
    return Icon(
      Animals.ant,
      color: color,
      size: size,
    );
  }

  static List<int> dx = [0, 0];
  static List<int> dy = [1, -1];
  static int numberOfDirections = 2;

  late int movingDirection;

  Ant(int x, int y) : super(x, y) {
    setRandomMovingDirection();
  }

  void move() {
    x += dx[movingDirection];
    y += dy[movingDirection];
  }

  void setRandomLocation(int notAllowedX, int notAllowedY) {
    List<int> _newLocation = getRandomLocation();
    while (x == _newLocation[0] && y == _newLocation[1]) {
      _newLocation = getRandomLocation();
    }
    x = _newLocation[0];
    y = _newLocation[1];
    setRandomMovingDirection();
  }

  void setRandomMovingDirection() {
    movingDirection = getRandomDirection();
  }

  static List<int> getRandomLocation() {
    return [
      Random.secure().nextInt(maxX) + 1,
      Random.secure().nextInt(maxY) + 1,
    ];
  }

  int getRandomDirection() {
    return Random.secure().nextInt(numberOfDirections);
  }
}
