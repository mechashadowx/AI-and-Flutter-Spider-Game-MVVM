import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:spider/src/viewmodel.dart';
import 'package:spider/src/widgets/widgets.dart' as custom;
import 'package:spider/src/viewmodel.dart' show ModesViewModel, Modes;

final List<String> algorithmsNames = [
  'Normal',
  'BFS',
  'DFS',
  'A* Search',
  'Heuristic-1',
  'Heuristic-2',
  'Heuristic-3',
];

final List<Modes> algorithmsModes = [
  Modes.Normal,
  Modes.BFS,
  Modes.DFS,
  Modes.A_STAR,
  Modes.H1,
  Modes.H2,
  Modes.H3,
];

final List<SizedBox> buttonsSpaces = [
  normalVSpace,
  smallVSpace,
  smallVSpace,
  normalVSpace,
  smallVSpace,
  smallVSpace,
  smallVSpace,
];

class ModesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GridViewModel>(
      builder: (context, grid, child) {
        return Consumer<ModesViewModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    custom.Title(title: 'Modes:'),
                    normalVSpace,
                    for (int i = 0; i < algorithmsModes.length; i++) ...[
                      custom.Button(
                        name: algorithmsNames[i],
                        onTap: () {
                          if (grid.isRunning) return;
                          print(grid.isRunning);
                          model.changeMode(context, algorithmsModes[i]);
                        },
                        active: model.mode == algorithmsModes[i],
                      ),
                      buttonsSpaces[i],
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
