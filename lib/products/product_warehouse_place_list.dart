import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:openshelves/main.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouseplace/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:redux/redux.dart';

class WarehousePlaceList extends StatelessWidget {
  final Store<AppState> store;
  final List<InventoryLevel> inventoryLevels;
  const WarehousePlaceList(
      {Key? key, required this.inventoryLevels, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: inventoryLevels.length,
        itemBuilder: (context, index) {
          return Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: ListTile(
                onTap: () {
                  getWarehousePlace(inventoryLevels[index].warehousePlacesId)
                      .then((warehousePlace) {
                    Navigator.pushNamed(context, WarehousePlacePage.url,
                        arguments: WarehousePlacePageArguments(warehousePlace));
                    // }, onError: () {
                    //   print('error');
                    // });
                  });
                },
                title: Text(inventoryLevels[index].warehousePlacesName),
                leading: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(children: [
                      Text(inventoryLevels[index].quantity,
                          style: (Theme.of(context).textTheme.headlineMedium)),
                    ])),
                trailing: const Icon(Icons.arrow_right),
              ));
        });
  }
}
