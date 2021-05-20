import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';

class Button extends StatelessWidget {
  final bool active;
  final String? name;
  final Function? onTap;

  Button({
    @required this.name,
    @required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: normalButtonHeight,
        width: normalButtonWidth,
        decoration: active ? activeButtonStyle : buttonStyle,
        child: Center(
          child: Text(
            name ?? '',
            style: active ? activeButtonTextStyle : buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
