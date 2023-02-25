import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/login/login_service.dart';
import 'package:openshelves/login/server_model.dart';
import 'package:openshelves/main.dart';
import 'package:redux/redux.dart';

class LoginForm extends StatefulWidget {
  final Store<AppState> store;
  const LoginForm({Key? key, required this.store}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final serverController = TextEditingController();

  final storage = const FlutterSecureStorage();
  late List<Server> server = [];
  late BuildContext dialogContext;
  late String? selectedServer = '';

  @override
  initState() {
    super.initState();

    serverController.text = 'https://';
    storage.read(key: 'server').then((value) {
      if (value != null) {
        value = '{"server": $value}';
        setState(() {
          var decoded = jsonDecode(value!);
          server = (decoded['server'] as List)
              .map((e) => Server.fromJson(e))
              .toList();
        });
      }
    });
    storage.read(key: 'selectedServer').then((value) {
      if (value != null) {
        selectedServer = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.pleaseLogin),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(label: Text('E-Mail')),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.userPassword)),
            ),
            DropdownButtonFormField(
                value: server.isNotEmpty && selectedServer != null
                    ? selectedServer
                    : 'https://',
                hint: Text(AppLocalizations.of(context)!.selectServerLabel),
                selectedItemBuilder: (BuildContext context) {
                  return server.map((e) {
                    return Text(e.uri);
                  }).toList();
                },
                items: server.isNotEmpty
                    ? server.map((e) {
                        return DropdownMenuItem(
                            value: e.uri,
                            child: Row(children: [
                              Text(e.uri),
                              IconButton(
                                  onPressed: () {
                                    server.remove(e);
                                    storage.write(
                                        key: 'server',
                                        value: jsonEncode(server));
                                    setState(() {
                                      server;
                                    });
                                  },
                                  icon: const Icon(Icons.delete))
                            ]));
                      }).toList()
                    : [
                        const DropdownMenuItem(
                            value: 'https://', child: Text('No Servers')),
                      ],
                onChanged: (value) {
                  storage.write(key: 'selectedServer', value: value.toString());
                }),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                              height: 300,
                              width: 200,
                              padding: const EdgeInsets.all(20),
                              child: Column(children: [
                                Text(AppLocalizations.of(context)!
                                    .addServerHeadline),
                                Form(
                                    child: Column(
                                  children: [
                                    TextFormField(
                                        controller: serverController,
                                        decoration: InputDecoration(
                                            label: Text(
                                                AppLocalizations.of(context)!
                                                    .serverLabel))),
                                    IconButton(
                                        onPressed: () {
                                          server.add(Server(
                                              uri: serverController.text));
                                          storage.write(
                                              key: 'server',
                                              value: jsonEncode(server));
                                          storage.write(
                                              key: 'selectedServer',
                                              value: serverController.text);
                                          setState(() {
                                            selectedServer =
                                                serverController.text;
                                            server;
                                          });
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.save))
                                  ],
                                ))
                              ])),
                        );
                      });
                },
                icon: const Icon(Icons.add)),
            ElevatedButton(
                onPressed: () {
                  var token =
                      login(emailController.text, passwordController.text);
                  token.then((strtoken) {
                    widget.store.dispatch(LogInAction(strtoken));
                    storage.write(key: 'token', value: strtoken);
                  }, onError: (message) {
                    final snackBar = SnackBar(
                      content: Text(message.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: Row(
                  children: const [Icon(Icons.login), Text('Login')],
                ))
          ],
        ));
  }
}
