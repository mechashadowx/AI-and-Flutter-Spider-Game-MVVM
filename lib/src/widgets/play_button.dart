import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';

class PlayButton extends StatelessWidget {
  final Function? onTap;

  PlayButton({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: fabSize,
        width: fabSize,
        decoration: fabStyle,
        child: Center(
          child: Icon(
            Icons.play_arrow_rounded,
            color: primary300,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}
