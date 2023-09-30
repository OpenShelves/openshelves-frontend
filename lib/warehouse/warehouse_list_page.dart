import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class WarehouseListPage extends StatefulWidget {
  final Store<AppState> store;
  const WarehouseListPage({Key? key, required this.store}) : super(key: key);
  static const String url = 'warehouses';

  @override
  State<WarehouseListPage> createState() => _WarehouseListPageState();
}

getList() {}

class _WarehouseListPageState extends State<WarehouseListPage> {
  getList() {
    return Row(children: [
      const OpenShelvesDrawer(),
      Expanded(
          child: FutureBuilder<List<Warehouse>>(
        future: getProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].address.name1 +
                        ' ' +
                        snapshot.data![index].address.city.toString()),
                    onTap: () {
                      print('go');
                      widget.store.dispatch(
                        SelectWarehouseAction(snapshot.data![index]),
                      );
                      Navigator.pushNamed(
                        context,
                        WarhouseForm.url,
                      );
                    },
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ))
    ]);
  }

  Future<List<Warehouse>> getProducts = getWarehouses();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: getList()),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: getList()),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    WarhouseForm.url,
                  );
                }),
            body: getList()));
  }
}
