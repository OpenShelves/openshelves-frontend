import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: openShelvesDrawer,
        appBar: openShelvesAppBar,
        body: Row(
          children: [],
        ));
  }
}
