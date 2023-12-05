import 'package:flutter/material.dart';
import 'package:openshelves/products/form/product_form_page.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';

class InventoryTableSource extends DataTableSource {
  List<InventoryLevel> data;

  BuildContext context;
  WarehousePlacePage widget;
  InventoryTableSource(
      {required this.data, required this.context, required this.widget});
  @override
  DataRow? getRow(int index) {
    final inventory = data[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(inventory.quantity)),
      DataCell(Text(inventory.productsName)),
      DataCell(Text(inventory.warehousePlacesName)),
      DataCell(IconButton(
          onPressed: () {
            getProductById(inventory.productsId).then((product) {
              // widget.store.dispatch(SelectProductAction(product));
              Navigator.pushNamed(
                context,
                ProductFormPage.url,
              );
            });
          },
          icon: const Icon(Icons.arrow_right)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class InventoryTable extends StatelessWidget {
  final WarehousePlace? wp;
  final WarehousePlacePage widget;
  const InventoryTable({Key? key, this.wp, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wp!.id! > 0
        ? FutureBuilder<List<InventoryLevel>>(
            future: wp!.id != null
                ? getInventoryLevelsByInventoryId(wp!.id!)
                : [] as Future<List<InventoryLevel>>,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Products found'));
                  }

                  return PaginatedDataTable(
                      rowsPerPage: snapshot.data!.length,
                      columns: const [
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Product')),
                        DataColumn(label: Text('Warehouse Place')),
                        DataColumn(label: Text('#')),
                      ],
                      source: InventoryTableSource(
                          data: snapshot.data!,
                          context: context,
                          widget: widget));
                } else {
                  return const Center(child: Text('No Products found'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        : const Text('no data');
  }
}
