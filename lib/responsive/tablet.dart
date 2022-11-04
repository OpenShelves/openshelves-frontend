import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: getOpenShelvesDrawer(context),
        appBar: openShelvesAppBar,
        body: Row(
          children: [],
        ));
  }
}
