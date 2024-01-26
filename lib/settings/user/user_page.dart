import 'package:flutter/material.dart';
import 'package:openshelves/settings/user/models/user_model.dart';
import 'package:openshelves/settings/user/services/user_service.dart';
import 'package:openshelves/widgets/drawer.dart';

class UserPage extends StatefulWidget {
  static const String url = 'user';
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User user = User(
    email: '',
    name: '',
  );
  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: openShelvesAppBar,
        body: Row(children: [
      const OpenShelvesDrawer(),
      Expanded(
          child: Container(
              // margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(30.0),
              child: Card(
                  child: Column(children: [
                TextFormField(
                  controller: TextEditingController(text: user.name),
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                  ),
                ),
                TextFormField(
                  controller: TextEditingController(text: user.email),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
              ]))))
    ]));
  }
}
