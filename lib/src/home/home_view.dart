import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spider/src/viewmodel.dart';
import 'package:spider/src/view.dart' as custom;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            custom.ModesView(),
            custom.GridView(),
            custom.DashboardView(),
          ],
        ),
      ),
    );
  }
}
