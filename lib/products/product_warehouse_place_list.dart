import 'package:flutter/material.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:redux/redux.dart';

class WarehousePlaceList extends StatelessWidget {
  final List<InventoryLevel> inventoryLevels;
  const WarehousePlaceList({Key? key, required this.inventoryLevels})
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
                  Navigator.pushNamed(
                    context,
                    WarehousePlacePage.url,
                  );
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
