import 'package:flutter/material.dart';
import 'package:openshelves/settings/tax/tax_list_page.dart';
import 'package:openshelves/widgets/drawer.dart';

class SettingsListPage extends StatefulWidget {
  static const String url = 'settings/list';
  const SettingsListPage({Key? key}) : super(key: key);

  @override
  State<SettingsListPage> createState() => _SettingsListPageState();
}

class _SettingsListPageState extends State<SettingsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: openShelvesAppBar,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {}),
        body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.monetization_on),
                        title: const Text('T A X'),
                        onTap: () {
                          Navigator.pushNamed(context, TaxListPage.url);
                        },
                      ),
                    ],
                  )))
        ]));
  }
}
