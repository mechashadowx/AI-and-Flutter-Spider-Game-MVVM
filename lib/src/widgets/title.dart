import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';

class Title extends StatelessWidget {
  final String title;

  Title({
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleStyle,
    );
  }
}
