import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spider/src/viewmodel.dart';

enum Modes {
  Normal,
  BFS,
  DFS,
  A_STAR,
  H1,
  H2,
  H3,
}

class ModesViewModel extends ChangeNotifier {
  late Modes mode;

  ModesViewModel() {
    mode = Modes.Normal;
  }

  void changeMode(BuildContext context, Modes newMode) {
    GridViewModel grid = Provider.of<GridViewModel>(context, listen: false);
    if (grid.isRunning) return;
    this.mode = newMode;
    grid.clear();
    notifyListeners();
  }
}
