import 'package:flutter/material.dart';
import 'package:openshelves/inventory/services/inventory_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_change_model.dart';

class InventoryChangeTableSource extends DataTableSource {
  List<InventoryChange> data;

//   BuildContext context;
//   WarehousePlacePage widget;
  InventoryChangeTableSource({required this.data});
//       {required this.data, required this.context, required this.widget});
  @override
  DataRow? getRow(int index) {
    final inventory = data[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(inventory.quantity.toString())),
      DataCell(Text(inventory.product.name)),
      DataCell(Text(inventory.createdAt.toString())),
      DataCell(Text(inventory.updatedAt.toString())),
//       DataCell(Text(inventory.productsName)),
//       DataCell(Text(inventory.warehousePlacesName)),
//       DataCell(IconButton(
//           onPressed: () {
//             getProductById(inventory.productsId).then((product) {
//               // widget.store.dispatch(SelectProductAction(product));
//               Navigator.pushNamed(
//                 context,
//                 ProductFormPage.url + '/${product.id}',
//               );
//             });
//           },
//           icon: const Icon(Icons.arrow_right)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class InventoryChangesTable extends StatefulWidget {
  final int warehousePlaceId;
  const InventoryChangesTable({Key? key, required this.warehousePlaceId})
      : super(key: key);

  @override
  State<InventoryChangesTable> createState() => _InventoryChangesTableState();
}

class _InventoryChangesTableState extends State<InventoryChangesTable> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InventoryChange>>(
      future: getInventoryChange(widget.warehousePlaceId.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Products found'));
            }

            return PaginatedDataTable(
                // rowsPerPage: 50,
                columns: const [
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Product')),
                  DataColumn(label: Text('createdAt')),
                  DataColumn(label: Text('updatedAt'))
                ],
                source: InventoryChangeTableSource(data: snapshot.data!));
          } else {
            return const Center(child: Text('No Products found'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
