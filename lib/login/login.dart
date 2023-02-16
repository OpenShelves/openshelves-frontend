import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/login/login_service.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  getLoginForm() {
    return Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Please Login'),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(label: Text('E-Mail')),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(label: Text('Password')),
            ),
            ElevatedButton(
                onPressed: () {
                  var token =
                      login(emailController.text, passwordController.text);
                  token.then((strtoken) {
                    widget.store.dispatch(LogInAction(strtoken));
                    print(widget.store.state.loginToken);
                    storage.write(key: 'token', value: strtoken);
                  });
                },
                child: Row(
                  children: const [Icon(Icons.login), Text('Login')],
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    return ResponsiveLayout(
      mobileBody: Scaffold(
        appBar: openShelvesAppBar,
        drawer: const OpenShelvesDrawer(),
        body: ListView(children: [getLoginForm()]),
      ),
      tabletBody: const Text("TO BE DONE"),
      desktopBody: Scaffold(
          appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            const OpenShelvesDrawer(),
            Expanded(child: getLoginForm())
            // Expanded(flex: 1, child: productTechDataForm)
          ])),
    );
  }
}
