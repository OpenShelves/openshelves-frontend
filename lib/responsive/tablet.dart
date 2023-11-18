import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/widgets/drawer.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const OpenShelvesDrawer(),
        appBar: openShelvesAppBar,
        body: const Row(
          children: [],
        ));
  }
}
