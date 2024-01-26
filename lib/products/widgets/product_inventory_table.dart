import 'package:flutter/material.dart';
import 'package:openshelves/products/form/product_form_page.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/invetory_table.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';

class InventoryTableSource extends DataTableSource {
  List<InventoryLevel> data;

  BuildContext context;
  ProductFormPage widget;
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
            getWarehousePlace(inventory.warehousePlacesId)
                .then((warehousePlace) {
              Navigator.pushNamed(
                context,
                WarehousePlacePage.url + '/${warehousePlace.id}',
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

class ProductInventoryTable extends StatelessWidget {
  final Product product;
  final ProductFormPage widget;
  const ProductInventoryTable(
      {Key? key, required this.product, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return product.id != null
        ? FutureBuilder<List<InventoryLevel>>(
            future: getInventoryLevelsByProductId(product.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return InventoryTable(
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
                  return Center(
                      child: Text(AppLocalizations.of(context)!.no_data_found));
                }
              } else {
                return Center(
                    child:
                        Text(AppLocalizations.of(context)!.waiting_for_data));
              }
            })
        : const Text('No Data');
  }
}
