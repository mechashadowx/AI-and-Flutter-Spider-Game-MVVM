import 'package:spider/src/animals/animal.dart';
import 'package:spider/src/animals/animals.dart';

class Grid {
  late Ant ant;
  late Spider spider;
  List<List<bool>> visited = [];

  Grid() {
    ant = Ant(5, 5);
    spider = Spider(12, 9);
    clearVisited();
  }

  void clearVisited() {
    visited = List.generate(
      maxX,
      (i) => List.generate(maxY, (j) => false),
    );
  }
}
