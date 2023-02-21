import 'package:flutter/material.dart';
import 'package:openshelves/widgets/drawer.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        const OpenShelvesDrawer(),
        Text('D A S H B O A R D'),
      ],
    ));
  }
}
