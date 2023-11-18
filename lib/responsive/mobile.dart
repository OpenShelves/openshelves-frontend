import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/widgets/drawer.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
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
