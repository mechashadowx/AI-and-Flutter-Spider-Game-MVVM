import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:spider/src/model.dart' show Dashboard;
import 'package:spider/src/viewmodel.dart';

class DashboardViewModel extends ChangeNotifier {
  late Dashboard dashboard;

  String speed = 'slow';

  DashboardViewModel() {
    dashboard = Dashboard(0, 0);
  }

  void clear() {
    dashboard = Dashboard(0, 0);
    notifyListeners();
  }

  int get antScore {
    return dashboard.antScore;
  }

  int get spiderScore {
    return dashboard.spiderScore;
  }

  void speedUp(BuildContext context) {
    final _grid = Provider.of<GridViewModel>(context, listen: false);
    _grid.speedUp();
    if (speed == 'slow') {
      speed = 'fast';
    } else {
      speed = 'slow';
    }
    notifyListeners();
  }

  void antGotPoint() {
    dashboard.antGotPoint();
    notifyListeners();
  }

  void spiderGotScore() {
    dashboard.spiderGotScore();
    notifyListeners();
  }
}
