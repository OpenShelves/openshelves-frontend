import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/login/login_form.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  final Store<AppState> store;
  const LoginPage({Key? key, required this.store}) : super(key: key);
  static const String url = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: Scaffold(
        appBar: openShelvesAppBar,
        drawer: const OpenShelvesDrawer(),
        body: ListView(children: [LoginForm(store: widget.store)]),
      ),
      tabletBody: Scaffold(
        appBar: openShelvesAppBar,
        drawer: const OpenShelvesDrawer(),
        body: ListView(children: [LoginForm(store: widget.store)]),
      ),
      desktopBody: Scaffold(
          appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            const OpenShelvesDrawer(),
            Expanded(child: LoginForm(store: widget.store))
          ])),
    );
  }
}
