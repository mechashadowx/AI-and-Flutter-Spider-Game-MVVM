import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:spider/src/viewmodel.dart';
import 'package:spider/src/view.dart' show Home;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GridViewModel>(
          create: (_) => GridViewModel(),
        ),
        ChangeNotifierProvider<DashboardViewModel>(
          create: (_) => DashboardViewModel(),
        ),
        ChangeNotifierProvider<ModesViewModel>(
          create: (_) => ModesViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Spider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: primary300,
        ),
        home: Home(),
      ),
    );
  }
}
