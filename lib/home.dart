import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  final Store<AppState> store;
  const HomePage({Key? key, required this.store}) : super(key: key);
  static const String url = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
          appBar: openShelvesAppBar,
          drawer: getOpenShelvesDrawer(context),
          body: Column(children: [Text('D A S H B O A R D ')]),
        ),
        tabletBody: const Text("TO BE DONE"),
        desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            getOpenShelvesDrawer(context),
            Column(
              children: [
                Text('D A S H B O A R D '),
                StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    print('${state.animal}');
                    return Text(state.animal);
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.store.dispatch(TestAction('Cat'));
                    },
                    child: const Text('Cat')),
              ],
            )
          ]),
        ));
  }
}
