const maxX = 16;
const maxY = 16;

class Animal {
  int x, y;

  Animal(this.x, this.y);

  List<int> getLocation() {
    return [x, y];
  }

  static bool isValidLocation(int x, int y) {
    return x <= maxX && x > 0 && y <= maxY && y > 0;
  }
}
