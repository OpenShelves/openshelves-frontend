import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/desktop.dart';
import 'package:openshelves/responsive/mobile.dart';
import 'package:openshelves/responsive/tablet.dart';
import 'package:openshelves/responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenShelves',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLayout(
        desktopBody: DesktopScaffold(),
        mobileBody: MobileScaffold(),
        tabletBody: TabletScaffold(),
      ),
    );
  }
}
