import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';
import 'package:spider/src/animals/animals.dart';

class Cell extends StatelessWidget {
  final int antAngle;
  final int? value;
  final bool hasAnt;
  final bool hasSpider;
  final Color color;

  Cell({
    required this.hasAnt,
    required this.antAngle,
    required this.hasSpider,
    this.value,
    this.color = primary400,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cellSize = size.height * 0.7 / 16;
    final antSize = cellSize * 0.6;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: cellSize,
        width: cellSize,
        decoration: cellStyle.copyWith(
          borderRadius: BorderRadius.circular(cellSize * 0.3),
          color: color,
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (hasAnt) antIcon(antSize, color),
              if (hasSpider) spiderIcon(antSize, color),
              if (value != null && !hasAnt) valueWidget(cellSize, value!),
            ],
          ),
        ),
      ),
    );
  }

  Widget valueWidget(double size, int value) {
    return Text(
      value.toString(),
      style: TextStyle(
        color: primary100,
        fontSize: size * 0.4,
      ),
    );
  }

  Widget antIcon(double size, Color cellColor) {
    return Transform.rotate(
      angle: antAngle * pi / 180,
      child: Ant.antIcon(
        size: size,
        color: cellColor == accent ? primary300 : primary100,
      ),
    );
  }

  Widget spiderIcon(double size, Color cellColor) {
    return Spider.spiderIcon(
      size: size,
      color: cellColor == accent ? primary300 : primary100,
    );
  }
}
