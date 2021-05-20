import 'package:flutter/material.dart';
import 'package:spider/src/model.dart';
import 'package:spider/src/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:spider/src/viewmodel.dart';
import 'package:spider/src/animals/animals.dart';
import 'package:spider/src/widgets/widgets.dart' as custom;
import 'package:spider/src/widgets/widgets.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late GridViewModel grid;
  late ModesViewModel modes;

  @override
  void initState() {
    super.initState();
    grid = Provider.of<GridViewModel>(context, listen: false);
    modes = Provider.of<ModesViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, model, child) {
        return Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      custom.Title(title: 'Score:'),
                      normalVSpace,
                      score(
                        Spider.spiderIcon(
                          color: model.spiderScore == Dashboard.maxScore
                              ? accent
                              : primary100,
                        ),
                        model.spiderScore,
                      ),
                      smallVSpace,
                      score(
                        Ant.antIcon(
                          color: model.antScore == Dashboard.maxScore
                              ? accent
                              : primary100,
                        ),
                        model.antScore,
                      ),
                      normalVSpace,
                      Text(
                        'First ${Dashboard.maxScore} points is\nthe WINNER!!',
                        style: TextStyle(
                          fontSize: smallFontSize * 1.5,
                          color: accent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  largeVSpace,
                  largeVSpace,
                  largeVSpace,
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          model.speedUp(context);
                        },
                        child: Container(
                          height: fabSize,
                          width: fabSize,
                          decoration: BoxDecoration(
                            color: model.speed == 'fast' ? accent : primary100,
                            borderRadius: BorderRadius.circular(fabSize),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.fast_forward_rounded,
                              color: primary300,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ),
                      smallVSpace,
                      PlayButton(
                        onTap: () => grid.run(modes.mode),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget score(Widget animalIcon, int score) {
    return Row(
      children: [
        Text(
          score.toString(),
          style: normalTextStyle.copyWith(
            color: score == 5 ? accent : primary100,
          ),
        ),
        smallHSpace,
        animalIcon,
      ],
    );
  }
}
