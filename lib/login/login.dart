import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/login/login_form.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  final Store<AppState> store;
  const LoginPage({Key? key, required this.store}) : super(key: key);
  static const String url = '/';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = const FlutterSecureStorage();
  @override
  initState() {
    super.initState();
    // storage.read(key: 'token').then((value) {
    //   if (value != null) {
    //     Navigator.pushNamed(context, '/dashboard');
    //   }
    // });
  }

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
          drawer: const OpenShelvesDrawer(),
          // floatingActionButton: FloatingActionButton(
          //     child: const Icon(Icons.add), onPressed: () {}),
          body: Center(
              child:
                  // const OpenShelvesDrawer(),
                  SizedBox(width: 500, child: LoginForm(store: widget.store))),
        ));
  }
}
