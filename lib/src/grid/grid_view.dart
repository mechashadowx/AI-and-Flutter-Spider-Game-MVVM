import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:spider/src/viewmodel.dart';
import 'package:spider/src/grid/view/cell.dart';

class GridView extends StatefulWidget {
  @override
  _GridViewState createState() => _GridViewState();
}

class _GridViewState extends State<GridView> {
  final _gridHeight = 16, _gridWidth = 16;

  late DashboardViewModel dashboard;
  late ModesViewModel modes;

  @override
  void initState() {
    super.initState();
    dashboard = Provider.of<DashboardViewModel>(context, listen: false);
    modes = Provider.of<ModesViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GridViewModel>(
      builder: (context, model, child) {
        model.setDashboard(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= _gridHeight; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int j = 1; j <= _gridWidth; j++)
                    GestureDetector(
                      onTap: () {
                        if (modes.mode == Modes.Normal) model.move(i, j);
                      },
                      child: Cell(
                        hasAnt: listEquals([i, j], model.getAntLocation()),
                        hasSpider:
                            listEquals([i, j], model.getSpiderLocation()),
                        antAngle: model.getAntAngle(),
                        value: model.values[i * 16 + j] ?? null,
                        color: model.cellColor(i, j, modes.mode),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }

  bool canSpiderReach(int x, int y, int spiderX, int spiderY) {
    return (x - spiderX).abs() == 2 && (y - spiderY).abs() == 1 ||
        (y - spiderY).abs() == 2 && (x - spiderX).abs() == 1;
  }
}
